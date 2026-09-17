defmodule EntitySports.Model.Responses.MatchOdds do
  @moduledoc """
  Match Odds API response (exchange)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:total_items, :integer)
    field(:total_pages, :integer)
    embeds_one(:match_info, Model.Match)
    embeds_one(:live_odds, Model.LiveOdd)
    embeds_many(:session_odds, Model.SessionOdd)
  end
end
