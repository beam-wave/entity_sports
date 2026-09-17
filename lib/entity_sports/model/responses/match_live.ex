defmodule EntitySports.Model.Responses.MatchLive do
  @moduledoc """
  Match Live API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:mid, :integer)
    field(:status, :integer)
    field(:status_str, :string)
    field(:game_state, :integer)
    field(:game_state_str, :string)
    field(:status_note, :string)
    field(:day_remaining_over, :string)
    field(:team_batting, :string)
    field(:team_bowling, :string)
    field(:live_inning_number, :integer)
    field(:commentary, :integer)
    field(:wagon, :integer)
    embeds_one(:live_score, Model.MatchLiveScore)
    embeds_many(:batsmen, Model.MatchLiveBatsmen)
    embeds_many(:bowlers, Model.MatchLiveBowler)
    embeds_many(:commentaries, Model.Commentary)
    embeds_one(:live_inning, Model.MatchInning)
    embeds_many(:teams, Model.TeamDetail)
    embeds_many(:players, Model.Player)
  end
end
