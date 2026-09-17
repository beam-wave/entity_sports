defmodule EntitySports.Model.WinPercentage do
  @moduledoc """
  Team win percentage (exchange match info), `[]` when not available
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_a_win, Number)
    field(:team_b_win, Number)
    field(:draw, Number)
  end
end
