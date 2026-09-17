defmodule EntitySports.Model.StatInning do
  @moduledoc """
  Innings statistics (manhattan, worm, partnership, ...)
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
    embeds_many(:fows, Model.Fow)
    # %{"manhattan" => [..], "worm" => [..], "runrates" => [..], "partnership" => [..],
    #   "runtypes" => [..], "wickets" => [..], "p2p" => [..], "extras" => [..]}
    field(:statistics, :map)
  end
end
