defmodule EntitySports.Model.CommentaryBowls do
  @moduledoc """
  Commentary bowler snapshot
  """
  use EntitySports.Schema

  embedded_schema do
    field(:bowler_id, :integer)
    field(:runs_conceded, :integer)
    field(:maidens, :integer)
    field(:wickets, :integer)
    field(:overs, Number)
  end
end
