defmodule EntitySports.Model.Responses.MultiMatchOdds do
  @moduledoc """
  Multiple Match Odds API response (exchange)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:total_items, :integer)
    field(:total_pages, :integer)
    embeds_many(:odds, Model.MatchOddsEntry)
  end

  # response is keyed by match id: %{"77363" => %{live_odds, session_odds}, ...}
  def prepare(params) do
    odds =
      params
      |> Map.drop(["total_items", "total_pages", "raw_response"])
      |> Enum.map(fn {match_id, entry} -> Map.put(entry, "match_id", match_id) end)

    Map.put(params, "odds", odds)
  end
end
