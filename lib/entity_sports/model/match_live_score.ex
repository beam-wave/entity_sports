defmodule EntitySports.Model.MatchLiveScore do
  @moduledoc """
  Live inning score model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:runs, :integer)
    field(:overs, Number)
    field(:wickets, :integer)
    field(:target, :integer)
    field(:runrate, Number)
    field(:required_runrate, Raw)
  end
end
