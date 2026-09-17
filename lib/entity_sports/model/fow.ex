defmodule EntitySports.Model.Fow do
  @moduledoc """
  Fall of wicket model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:name, :string)
    field(:batsman_id, :integer)
    field(:runs, :integer)
    field(:balls, :integer)
    field(:balls_faced, :integer)
    field(:how_out, :string)
    field(:score_at_dismissal, :integer)
    field(:overs_at_dismissal, Number)
    field(:bowler_id, :integer)
    field(:dismissal, :string)
    field(:number, :integer)
    field(:order, :integer)
  end
end
