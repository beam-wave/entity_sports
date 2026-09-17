defmodule EntitySports.Model.ExtraRuns do
  @moduledoc """
  Innings extra runs model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:byes, :integer)
    field(:legbyes, :integer)
    field(:wides, :integer)
    field(:noballs, :integer)
    field(:penalty, :integer)
    field(:total, :integer)
  end
end
