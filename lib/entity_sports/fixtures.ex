defmodule EntitySports.Fixtures do
  @moduledoc """
  Sample API payloads captured from the EntitySports documentation
  (`priv/fixtures/<scope>/<name>.json`). Backs `EntitySports.Stub` and
  `EntitySports.Exchange.Stub`.
  """

  @type scope :: :v2 | :exchange

  @doc "Raw JSON body of the fixture."
  @spec body(scope, atom() | String.t()) :: String.t()
  def body(scope, name) do
    :entity_sports
    |> :code.priv_dir()
    |> Path.join(["fixtures", "/", to_string(scope), "/", "#{name}.json"])
    |> File.read!()
  end

  @doc "Decoded `response` node of the fixture."
  @spec response(scope, atom() | String.t()) :: map()
  def response(scope, name) do
    scope
    |> body(name)
    |> Jason.decode!()
    |> Map.fetch!("response")
  end

  @doc "Renders the fixture through the given response function."
  @spec render(scope, atom() | String.t(), (map() -> result)) :: result when result: any()
  def render(scope, name, render_fn), do: render_fn.(response(scope, name))
end
