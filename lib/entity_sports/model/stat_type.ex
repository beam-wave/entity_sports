defmodule EntitySports.Model.StatType do
  @moduledoc """
  Competition statistic type group
  """
  use EntitySports.Schema

  embedded_schema do
    field(:group_title, :string)
    # %{"batting_most_runs" => "Most Runs", ...}
    field(:types, :map)
  end
end
