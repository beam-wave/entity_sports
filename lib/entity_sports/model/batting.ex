defmodule EntitySports.Model.Batting do
  @moduledoc """
  Player batting stats (per format)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:match_id, :integer)
    field(:inning_id, :integer)
    field(:matches, :integer)
    field(:innings, :integer)
    field(:notout, :integer)
    field(:runs, :integer)
    field(:balls, :integer)
    field(:highest, :integer)
    field(:run100, :integer)
    field(:run50, :integer)
    field(:run4, :integer)
    field(:run6, :integer)
    field(:average, Number)
    field(:strike, Number)
    field(:catches, :integer)
    field(:stumpings, :integer)
    field(:fastest50balls, :integer)
    field(:fastest100balls, :integer)
  end
end
