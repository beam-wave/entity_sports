defmodule EntitySports.Utils do
  @moduledoc """
  Utility Module
  """
  alias EntitySports.Constants
  require Logger
  @http_client_opts Application.compile_env(:entity_sports, :http_client_opts, [])

  @doc """
  POSTs the given body to the given URI with an authorized request & standard
  options, logging the result.
  If a map, the body is JSON encoded before POSTing. Will raise if encoding
  fails.
  """
  @spec post(
          url :: String.t(),
          body :: String.t() | map(),
          headers :: HTTPoison.Base.headers(),
          extra_opts :: keyword()
        ) ::
          HTTPoison.Response.t()
  def post(url, body, headers, extra_opts \\ [timeout: 50_000, recv_timeout: 50_000])

  def post(url, body, headers, extra_opts) when is_binary(body) do
    response = HTTPoison.post(url, body, headers, extra_opts)

    Logger.debug(
      "POST #{inspect(url)}: #{inspect(headers)}: #{inspect(response)} : #{inspect(body)}"
    )

    response
  end

  @doc """
  GET the given body to the given URI with an authorized request & standard
  options, logging the result.
  """
  @spec get(
          url :: String.t(),
          headers :: HTTPoison.Base.headers(),
          extra_opts :: keyword()
        ) ::
          HTTPoison.Response.t()
  def get(
        url,
        headers \\ [{"Content-Type", "application/json"}, {"accept", "application/json"}],
        extra_opts \\ opts(timeout: 50_000, recv_timeout: 50_000)
      )

  def get(url, headers, extra_opts) do
    response = HTTPoison.get(url, headers, extra_opts)

    Logger.debug("GET #{inspect(url)}: #{inspect(headers)}: #{inspect(response)}}")

    response
  end

  @doc """
  Helper that deserializes a request response using the given deserializing
  function if the given `response` has a successful status. Otherwise, returns
  an error tuple instead.
  The deserializing function is skipped when there is no body; an empty string
  is returned instead.
  """
  @spec deserialize_response(response :: HTTPoison.Response.t(), (String.t() -> deserialized)) ::
          {:ok, deserialized | String.t()} | {:error, integer(), String.t()}
        when deserialized: any()

  def deserialize_response({:ok, %HTTPoison.Response{status_code: sc, body: ""}}, _deserialize_fn)
      when sc >= 200 and sc < 300 do
    Logger.error("Error response: #{sc}: empty body")
    {:error, sc, ""}
  end

  def deserialize_response(
        {:ok, %HTTPoison.Response{status_code: sc, body: body}},
        deserialize_fn
      )
      when sc >= 200 and sc < 300 do
    with {:ok, decoded_body} <- Jason.decode(body),
         {:ok, _res} <- {Map.get(decoded_body, "status") |> status(), decoded_body} do
      deserialize_fn.(Map.get(decoded_body, "response"))
    else
      {:error, %Jason.DecodeError{data: err}} -> {:error, 0, %{body: body, error: err}}
      {:error, decoded_body} -> {:error, sc, error_message(decoded_body)}
    end
  end

  def deserialize_response(
        {:ok, %HTTPoison.Response{status_code: status_code, body: body} = response},
        _deserialize_fn
      ) do
    Logger.error("Error response: #{status_code}: #{body} \n Raw Response: #{inspect(response)}")
    {:error, status_code, body}
  end

  def deserialize_response({:error, %HTTPoison.Error{} = resp}, _deserialize_fn) do
    message = Exception.message(resp)
    Logger.error("deserialize_response/2: Error response: #{message}")
    Logger.error("deserialize_response/2: Error response: #{inspect(resp)}")
    {:error, 0, message}
  end

  @doc """
  Builds a request URL from a base, a path and query params.
  Params with a `nil` value are dropped. Keyword or map params accepted.
  """
  @spec build_url(base :: String.t(), path :: String.t(), params :: keyword() | map()) ::
          String.t()
  def build_url(base, path, params \\ []) do
    query =
      params
      |> Enum.reject(fn {_k, v} -> is_nil(v) end)
      |> Enum.map(fn {k, v} -> {k, to_param(v)} end)
      |> URI.encode_query()

    case query do
      "" -> base <> path
      query -> base <> path <> "?" <> query
    end
  end

  defp to_param(value) when is_list(value), do: Enum.map_join(value, ",", &to_string/1)
  defp to_param(true), do: "true"
  defp to_param(false), do: "false"
  defp to_param(value), do: to_string(value)

  @doc """
  Returns an options Keyword for request functions. Merges the default options
  (from config) with the given `extra`.
  """
  @spec opts(keyword :: keyword()) :: keyword()
  def opts(extra \\ []),
    do: Keyword.merge(@http_client_opts, extra)

  @doc """
  Pagination query params from `:page`/`:paged` and `:per_page`/`:size` opts.
  """
  def page_params(opts),
    do: [paged: opts[:page] || opts[:paged], per_page: opts[:per_page] || opts[:size]]

  @doc "Match status code from atom / integer, `nil` passthrough."
  def match_status(nil), do: nil
  def match_status(status), do: Constants.status(status)

  @doc """
  Query params for the matches list endpoints (`/matches`).
  """
  def match_filters(opts) do
    date =
      case {opts[:date], opts[:start_date], opts[:end_date]} do
        {date, _, _} when is_binary(date) ->
          date

        {_, start_date, end_date} when is_binary(start_date) and is_binary(end_date) ->
          "#{start_date}_#{end_date}"

        _ ->
          nil
      end

    [
      status: match_status(opts[:status]),
      format: opts[:format] && Constants.format(opts[:format]),
      date: date,
      timezone: opts[:timezone],
      pre_squad: opts[:pre_squad],
      day: opts[:day],
      session: opts[:session]
    ] ++ page_params(opts)
  end

  # `status` is "ok" on success; "error" / "unauthorized" / "accessdenied" /
  # "forbidden" or a numeric code (i.e. 202 "match not found") otherwise.
  defp status("ok"), do: :ok
  defp status(_), do: :error

  defp error_message(%{"response" => response}) when not is_nil(response), do: response
  defp error_message(%{"message" => message}), do: message
  defp error_message(body), do: body
end
