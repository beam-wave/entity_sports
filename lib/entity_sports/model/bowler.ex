defmodule EntitySports.Model.Bowler do
  @moduledoc """
  Scorecard bowler model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:name, :string)
    field(:bowler_id, :integer)
    field(:bowling, :string)
    field(:position, :string)
    field(:overs, Number)
    field(:maidens, :integer)
    field(:runs_conceded, :integer)
    field(:wickets, :integer)
    field(:noballs, :integer)
    field(:wides, :integer)
    field(:econ, Number)
    field(:run0, :integer)
    field(:bowledcount, :integer)
    field(:lbwcount, :integer)
  end
end
