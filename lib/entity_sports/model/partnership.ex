defmodule EntitySports.Model.Partnership do
  @moduledoc """
  Batting partnership model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:runs, :integer)
    field(:balls, :integer)
    field(:balls_faced, :integer)
    field(:overs, Number)
    field(:order, :integer)
    embeds_many(:batsmen, Model.CommentaryBats)
  end
end
