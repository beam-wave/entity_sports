defmodule EntitySports.Model.MatchLiveBowler do
  @moduledoc """
  Live bowler model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:name, :string)
    field(:bowler_id, :integer)
    field(:overs, Number)
    field(:runs_conceded, :integer)
    field(:wickets, :integer)
    field(:maidens, :integer)
    field(:econ, Number)
  end
end
