defmodule EntitySports.Model.CommentaryBats do
  @moduledoc """
  Commentary batsman snapshot
  """
  use EntitySports.Schema

  embedded_schema do
    field(:batsman_id, :integer)
    field(:name, :string)
    field(:runs, :integer)
    field(:balls, :integer)
    field(:balls_faced, :integer)
    field(:fours, :integer)
    field(:sixes, :integer)
  end
end
