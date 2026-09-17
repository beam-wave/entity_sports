defmodule EntitySports.Model.Responses.CompetitionTeams do
  @moduledoc """
  Competition Teams / Rounds Teams API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:total_teams, :integer)
    embeds_many(:teams, Model.TeamDetail)
  end
end
