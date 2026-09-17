defmodule EntitySports.Model.Toss do
  @moduledoc """
  Toss model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:text, :string)
    # winning team id
    field(:winner, :integer)
    # 1 - Batting, 2 - Fielding
    field(:decision, :integer)
  end
end
