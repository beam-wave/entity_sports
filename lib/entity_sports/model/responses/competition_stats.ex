defmodule EntitySports.Model.Responses.CompetitionStats do
  @moduledoc """
  Competition Statistic Types / Competition Statistic API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:total_items, :integer)
    field(:total_pages, :integer)
    # ["t20", ...]
    field(:formats, Raw)
    field(:format, :string)
    embeds_many(:stats, Model.CompetitionStat)
    embeds_many(:stat_types, Model.StatType)
    embeds_many(:teams, Model.TeamSummary)
  end
end
