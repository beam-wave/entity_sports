defmodule EntitySports.Model.MatchOddsEntry do
  @moduledoc """
  Odds for one match (multiple match odds api)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:match_id, :integer)
    embeds_one(:live_odds, Model.LiveOdd)
    embeds_many(:session_odds, Model.SessionOdd)
  end
end
