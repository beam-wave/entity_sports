defmodule EntitySports.Model.Responses.TeamPlayers do
  @moduledoc """
  Team Players API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:team, Model.TeamDetail)
    embeds_many(:players, Model.Player)
    embeds_one(:players_by_format, Model.PlayersByFormat)
  end

  # payload lives under `items` and players are grouped by format
  def prepare(%{"items" => %{} = items} = params) do
    params
    |> Map.delete("items")
    |> Map.merge(items)
    |> prepare()
  end

  def prepare(%{"players" => %{} = by_format} = params) do
    params
    |> Map.put("players_by_format", by_format)
    |> Map.put("players", by_format |> Map.values() |> List.flatten())
  end

  def prepare(params), do: params
end
