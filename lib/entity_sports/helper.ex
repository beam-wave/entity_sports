defmodule EntitySports.Helper do
  @moduledoc """
  Helper Module
  """

  @doc """
  Helper for Render Many
  """
  def render_many(nil, _mod), do: {:ok, []}

  def render_many(items, mod) when is_list(items) do
    result =
      items
      |> Enum.reduce_while([], fn item, response ->
        case mod.(item) do
          {:ok, resp} -> {:cont, [resp | response]}
          {:error, changeset, response} -> {:halt, {:error, changeset, response}}
        end
      end)

    case result do
      {:error, _changeset, _response} = err -> err
      items -> {:ok, Enum.reverse(items)}
    end
  end

  # Some list endpoints return a map keyed by id instead of a list
  def render_many(items, mod) when is_map(items), do: render_many(Map.values(items), mod)

  @doc """
  Renders a paginated list response (`items`, `total_pages`, `total_items`)
  as `{:ok, items, total_pages, total_items}`. Page counters are `nil` when
  the endpoint does not paginate.
  """
  def render_page(response, key \\ "items", mod) do
    response[key]
    |> render_many(mod)
    |> add_pagination(
      response["total_pages"] |> to_integer(),
      response["total_items"] |> to_integer()
    )
  end

  defp add_pagination({:ok, items}, total_pages, total_items),
    do: {:ok, items, total_pages, total_items}

  defp add_pagination(err, _total_pages, _total_items), do: err

  @doc """
  Helper for Appending Raw Response
  """
  def append_raw_response(response, raw_response),
    do: Map.put(response, "raw_response", raw_response)

  @doc """
  Helper for Appending Pagination Data
  """
  def maybe_add_pagination({:ok, _items} = res, nil, nil), do: res

  def maybe_add_pagination({:ok, _items} = res, total_pages, total_items),
    do: res |> Tuple.append(total_pages) |> Tuple.append(total_items)

  def maybe_add_pagination(err, _total_items, _total_pages), do: err

  def to_integer(value) when is_binary(value) do
    case Integer.parse(value) do
      {int, _} -> int
      :error -> nil
    end
  end

  def to_integer(value), do: value

  @doc """
  Normalises params before casting embeds.

  EntitySports uses `[]` or `""` for absent objects and sometimes an object
  where a list is expected. `embeds_one` keys listed under `:one` (and `:map`
  fields) are set to `nil` unless they hold a map; `embeds_many` keys listed
  under `:many` are set to `[]` unless they hold a list.
  """
  def sanitize(params, opts) when is_map(params) do
    params = Enum.reduce(Keyword.get(opts, :one, []), params, &sanitize_one/2)
    Enum.reduce(Keyword.get(opts, :many, []), params, &sanitize_many/2)
  end

  def sanitize(params, _opts), do: params

  defp sanitize_one(key, params) do
    case fetch(params, key) do
      {:ok, k, value} when is_map(value) -> Map.put(params, k, value)
      {:ok, k, _value} -> Map.put(params, k, nil)
      :error -> params
    end
  end

  defp sanitize_many(key, params) do
    case fetch(params, key) do
      {:ok, k, value} when is_list(value) -> Map.put(params, k, value)
      # object keyed by id, i.e. %{"1" => %{...}}
      {:ok, k, value} when is_map(value) -> Map.put(params, k, Map.values(value))
      {:ok, k, _value} -> Map.put(params, k, [])
      :error -> params
    end
  end

  defp fetch(params, key) do
    string_key = to_string(key)

    cond do
      Map.has_key?(params, string_key) -> {:ok, string_key, Map.get(params, string_key)}
      Map.has_key?(params, key) -> {:ok, key, Map.get(params, key)}
      true -> :error
    end
  end

  @doc """
  Renames a key in params (i.e. `"match-playing11"` -> `"match_playing11"`).
  """
  def rename_key(params, from, to) when is_map(params) do
    case Map.pop(params, from) do
      {nil, params} -> params
      {value, params} -> Map.put(params, to, value)
    end
  end

  def rename_key(params, _from, _to), do: params
end
