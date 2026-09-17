defmodule EntitySports.Model.Bowling do
  @moduledoc """
  Player bowling stats (per format)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:match_id, :integer)
    field(:inning_id, :integer)
    field(:matches, :integer)
    field(:innings, :integer)
    field(:balls, :integer)
    field(:overs, Number)
    field(:runs, :integer)
    field(:wickets, :integer)
    field(:bestinning, :string)
    field(:bestmatch, :string)
    field(:econ, Number)
    field(:average, Number)
    field(:strike, Number)
    field(:wicket4i, :integer)
    field(:wicket5i, :integer)
    field(:wicket10m, :integer)
    field(:hattrick, :integer)
    field(:expensive_over_runs, :integer)
  end
end
