defmodule EntitySports.Model.Responses.IccRanks do
  @moduledoc """
  ICC Ranking API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:ranks, Model.IccRankGroup)
    embeds_one(:women_ranks, Model.IccRankGroup)
    field(:groups, Raw)
    field(:formats, Raw)
  end
end
