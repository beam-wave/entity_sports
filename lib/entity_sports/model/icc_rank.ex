defmodule EntitySports.Model.IccRank do
  @moduledoc """
  ICC ranking row
  """
  use EntitySports.Schema

  embedded_schema do
    field(:rank, :integer)
    field(:pid, :integer)
    field(:tid, :integer)
    field(:player, :string)
    field(:team, :string)
    field(:rating, :integer)
    field(:points, :integer)
  end
end
