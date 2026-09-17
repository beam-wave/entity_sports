defmodule EntitySports.Model.Responses.CompetitionSquads do
  @moduledoc """
  Competition Squads API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    # per_match or per_team
    field(:squad_type, :string)
    embeds_many(:squads, Model.Squad)
  end
end
