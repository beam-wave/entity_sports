defmodule EntitySports.Model.Responses.MatchScorecard do
  @moduledoc """
  Match Scorecard API response
  """
  use EntitySports.Schema
  require EntitySports.Model.MatchFields

  embedded_schema do
    field(:raw_response, :map)
    EntitySports.Model.MatchFields.fields()
    field(:current_over, :string)
    field(:previous_over, :string)
    embeds_one(:man_of_the_match, Model.NamedPlayer)
    field(:man_of_the_series, Raw)
    field(:is_followon, :integer)
    field(:team_batting_first, :string)
    field(:team_batting_second, :string)
    field(:last_five_overs, :string)
    field(:day_remaining_over, :string)
    field(:pre_match_odds, Raw)
    field(:match_notes, Raw)
    embeds_many(:innings, Model.MatchInning)
    embeds_many(:players, Model.Player)
  end
end
