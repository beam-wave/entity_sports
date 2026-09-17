defmodule EntitySports.Model.WagonInning do
  @moduledoc """
  Innings wagon wheel data
  """
  use EntitySports.Schema

  embedded_schema do
    field(:inning_id, :integer)
    field(:number, :integer)
    field(:name, :string)
    field(:runs, :integer)
    field(:overs, Number)
    field(:wickets, :integer)
    field(:status, :integer)
    field(:result, :integer)
    field(:batting_team_id, :integer)
    field(:fielding_team_id, :integer)
    embeds_many(:batsmen, Model.Batsman)
    embeds_many(:bowlers, Model.Bowler)
    # list of positional rows, see `wagon_fields` on the response for column names
    field(:wagons, Raw)
  end
end
