defmodule EntitySports.Model.Pitch do
  @moduledoc """
  Match pitch condition model. See Cricket Reference > Ground Condition
  """
  use EntitySports.Schema

  embedded_schema do
    field(:pitch_condition, :string)
    field(:batting_condition, :string)
    field(:pace_bowling_condition, :string)
    field(:spine_bowling_condition, :string)
  end
end
