defmodule EntitySports.Model.TeamSquad do
  @moduledoc """
  Match squad for one team
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_id, :integer)
    embeds_many(:squads, Model.SquadPlayer)
  end
end
