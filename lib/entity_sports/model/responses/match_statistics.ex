defmodule EntitySports.Model.Responses.MatchStatistics do
  @moduledoc """
  Match Statistics API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:is_followon, :integer)
    embeds_many(:innings, Model.StatInning)
    embeds_many(:teams, Model.TeamSummary)
    embeds_many(:players, Model.PlayerSummary)
    # exchange only
    field(:venue_stats, Raw)
    field(:venue_bowling_report, Raw)
    field(:session_progression, Raw)
  end
end
