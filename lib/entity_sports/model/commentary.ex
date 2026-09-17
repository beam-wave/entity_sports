defmodule EntitySports.Model.Commentary do
  @moduledoc """
  Ball by ball commentary model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:event_id, :string)
    # ball, overend, wicket, ..
    field(:event, :string)
    field(:batsman_id, :integer)
    field(:bowler_id, :integer)
    # integer on live api, "over.ball" like string on innings commentary
    field(:over, Raw)
    field(:ball, :string)
    field(:score, Raw)
    field(:commentary, :string)
    field(:text, :string)
    field(:timestamp, :integer)
    field(:runs, :integer)
    field(:run, :integer)
    field(:noball_run, :integer)
    field(:wide_run, :integer)
    field(:bye_run, :integer)
    field(:legbye_run, :integer)
    field(:bat_run, :integer)
    field(:noball, :boolean)
    field(:wideball, :boolean)
    field(:six, :boolean)
    field(:four, :boolean)
    field(:noball_dismissal, :boolean)
    field(:ballverify, :boolean)
    field(:over_end_verify, :boolean)
    # live api keys
    embeds_many(:bats, Model.CommentaryBats)
    embeds_many(:bowls, Model.CommentaryBowls)
    # innings commentary api keys
    embeds_many(:batsmen, Model.CommentaryBats)
    embeds_many(:bowlers, Model.CommentaryBowls)
  end
end
