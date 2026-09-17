defmodule EntitySports.Model.MatchLiveBatsmen do
  @moduledoc """
  Live batsman model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:name, :string)
    field(:batsman_id, :integer)
    field(:runs, :integer)
    field(:balls_faced, :integer)
    field(:fours, :integer)
    field(:sixes, :integer)
    field(:strike_rate, Number)
  end
end
