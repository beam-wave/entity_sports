defmodule EntitySports.Model.SquadPlayer do
  @moduledoc """
  Match squad (playing 11) player
  """
  use EntitySports.Schema

  embedded_schema do
    field(:player_id, :integer)
    field(:name, :string)
    # "true" / "false"
    field(:substitute, :string)
    field(:out, :string)
    field(:in, :string)
    field(:playing11, :string)
    # bat, bowl, all, wk, cap, wkcap, squad
    field(:role, :string)
    field(:role_str, :string)
  end
end
