defmodule EntitySports.Model.MatchInning do
  @moduledoc """
  Match innings model (scorecard / commentary / live)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:iid, :integer)
    field(:number, :integer)
    field(:name, :string)
    field(:short_name, :string)
    # see EntitySports.Constants.inning_status/1
    field(:status, :integer)
    field(:issuperover, :string)
    # see EntitySports.Constants.inning_result/1
    field(:result, :integer)
    field(:batting_team_id, :integer)
    field(:fielding_team_id, :integer)
    field(:scores, :string)
    field(:scores_full, :string)
    field(:max_over, :string)
    field(:target, :string)
    field(:innings_create_verify, :string)
    field(:innings_result_verify, :string)
    # string ("4 1 W 0 6") or [] when absent
    field(:recent_scores, Raw)
    field(:last_five_overs, Raw)
    field(:last_ten_overs, Raw)
    # %{"p1" => %{"startover" => .., "endover" => ..}} or []
    field(:powerplay, Raw)
    # %{"batting" => %{..}, "bowling" => %{..}}
    field(:review, Raw)
    embeds_many(:batsmen, Model.Batsman)
    embeds_many(:bowlers, Model.Bowler)
    embeds_many(:fielder, Model.Fielder)
    embeds_many(:fows, Model.Fow)
    embeds_one(:last_wicket, Model.Fow)
    embeds_one(:extra_runs, Model.ExtraRuns)
    embeds_one(:equations, Model.Equations)
    embeds_one(:current_partnership, Model.Partnership)
    embeds_many(:did_not_bat, Model.DidNotBat)
  end
end
