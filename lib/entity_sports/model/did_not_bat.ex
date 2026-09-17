defmodule EntitySports.Model.DidNotBat do
  @moduledoc """
  Player id + name pair
  """
  use EntitySports.Schema

  embedded_schema do
    field(:player_id, :integer)
    field(:name, :string)
  end
end
