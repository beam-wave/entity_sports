defmodule EntitySports.Model.Batsman do
  @moduledoc """
  Scorecard batsman model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:name, :string)
    field(:batsman_id, :integer)
    field(:batting, :string)
    field(:position, :string)
    field(:role, :string)
    field(:role_str, :string)
    field(:runs, :integer)
    field(:balls_faced, :integer)
    field(:fours, :integer)
    field(:sixes, :integer)
    field(:run0, :integer)
    field(:run1, :integer)
    field(:run2, :integer)
    field(:run3, :integer)
    field(:run5, :integer)
    field(:how_out, :string)
    field(:dismissal, :string)
    field(:strike_rate, Number)
    field(:bowler_id, :string)
    field(:first_fielder_id, :string)
    field(:second_fielder_id, :string)
    field(:third_fielder_id, :string)
  end
end
