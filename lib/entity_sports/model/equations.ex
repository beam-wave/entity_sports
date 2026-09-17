defmodule EntitySports.Model.Equations do
  @moduledoc """
  Innings equations model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:runs, :integer)
    field(:wickets, :integer)
    field(:overs, Number)
    field(:bowlers_used, :integer)
    field(:runrate, Number)
  end
end
