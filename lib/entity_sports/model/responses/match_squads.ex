defmodule EntitySports.Model.Responses.MatchSquads do
  @moduledoc """
  Match Playing11 (squads) API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:teama, Model.TeamSquad)
    embeds_one(:teamb, Model.TeamSquad)
    embeds_many(:teams, Model.TeamDetail)
    embeds_many(:players, Model.Player)
  end
end
