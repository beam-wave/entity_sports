defmodule EntitySports.Model.CompetitionStat do
  @moduledoc """
  Competition statistic row (batting, bowling or team)
  """
  use EntitySports.Schema

  embedded_schema do
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
    field(:catches, :integer)
    field(:stumpings, :integer)
    field(:fastest50balls, :integer)
    field(:fastest100balls, :integer)
    field(:average, Number)
    field(:strike, Number)
    field(:overs, Number)
    field(:wickets, :integer)
    field(:maidens, :integer)
    field(:bestinning, :string)
    field(:bestmatch, :string)
    field(:econ, Number)
    field(:wicket4i, :integer)
    field(:wicket5i, :integer)
    field(:wicket10m, :integer)
    field(:hattrick, :integer)
    field(:runs_conceded, :integer)
    field(:match_id, :integer)
    field(:inning_id, :integer)
    embeds_one(:team, Model.TeamDetail)
    embeds_one(:player, Model.Player)
    embeds_one(:match, Model.Match)
  end
end
