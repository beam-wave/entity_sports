defmodule EntitySports.Model.Responses.CompetitionOverview do
  @moduledoc """
  Competition Overview (v2) / Competition Information (exchange) API response
  """
  use EntitySports.Schema
  alias EntitySports.Model.Responses

  embedded_schema do
    field(:raw_response, :map)
    field(:cid, :integer)
    field(:title, :string)
    field(:abbr, :string)
    field(:type, :string)
    field(:category, :string)
    field(:game_format, :string)
    field(:status, :string)
    field(:season, :string)
    field(:datestart, :date)
    field(:dateend, :date)
    field(:country, :string)
    field(:total_matches, :integer)
    field(:total_rounds, :integer)
    field(:total_teams, :integer)
    # total number of standing tables
    field(:table, :integer)
    embeds_one(:man_of_the_series, Model.NamedPlayer)
    embeds_many(:rounds, Model.Round)
    embeds_many(:venue_list, Model.CompetitionVenue)
    # exchange only
    embeds_many(:teams, Model.TeamDetail)
    embeds_one(:standing, Responses.CompetitionStandings)
  end
end
