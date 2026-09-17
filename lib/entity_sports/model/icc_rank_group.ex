defmodule EntitySports.Model.IccRankGroup do
  @moduledoc """
  ICC rankings grouped by category
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:batsmen, Model.IccRankCategory)
    embeds_one(:bowlers, Model.IccRankCategory)
    embeds_one(:allrounders, Model.IccRankCategory)
    embeds_one(:teams, Model.IccRankCategory)
  end
end
