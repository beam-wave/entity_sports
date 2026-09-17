defmodule EntitySports.Model.IccRankCategory do
  @moduledoc """
  ICC rankings for one category (batsmen, bowlers, all-rounders, teams) by format
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_many(:odis, Model.IccRank)
    embeds_many(:tests, Model.IccRank)
    embeds_many(:t20s, Model.IccRank)
  end
end
