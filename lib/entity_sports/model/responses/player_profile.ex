defmodule EntitySports.Model.Responses.PlayerProfile do
  @moduledoc """
  Player Profile API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:player, Model.Player)
  end
end
