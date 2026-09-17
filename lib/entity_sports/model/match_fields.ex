defmodule EntitySports.Model.MatchFields do
  @moduledoc """
  Schema fields shared by every match object (list items, match info,
  scorecard).
  """

  @doc "Injects the match fields into an `embedded_schema`."
  defmacro fields do
    quote do
      field(:match_id, :integer)
      field(:title, :string)
      # contains both teams short name, ie Ind vs Aus
      field(:short_title, :string)
      # match format + number or event name, ie: Final, 2nd ODI
      field(:subtitle, :string)
      field(:match_number, :string)
      # see EntitySports.Constants.format/1
      field(:format, :integer)
      field(:format_str, :string)
      # see EntitySports.Constants.status/1
      field(:status, :integer)
      field(:status_str, :string)
      field(:status_note, :string)
      # "true" / "false"
      field(:verified, :string)
      field(:pre_squad, :string)
      field(:odds_available, :string)
      # see EntitySports.Constants.game_state/1
      field(:game_state, :integer)
      field(:game_state_str, :string)
      # 0 international, 1 domestic
      field(:domestic, :string)
      embeds_one(:competition, EntitySports.Model.Competition)
      embeds_one(:teama, EntitySports.Model.Team)
      embeds_one(:teamb, EntitySports.Model.Team)
      # GMT (UTC +0)
      field(:date_start, :naive_datetime)
      field(:date_end, :naive_datetime)
      field(:timestamp_start, :integer)
      field(:timestamp_end, :integer)
      # IST (UTC +05:30)
      field(:date_start_ist, :string)
      field(:date_end_ist, :string)
      embeds_one(:venue, EntitySports.Model.Venue)
      field(:umpires, :string)
      field(:referee, :string)
      field(:equation, :string)
      field(:live, :string)
      field(:result, :string)
      # see EntitySports.Constants.result_type/1
      field(:result_type, :integer)
      field(:win_margin, :string)
      field(:winning_team_id, :integer)
      # 0,2 - not available, 1 - available
      field(:commentary, :integer)
      field(:wagon, :integer)
      field(:latest_inning_number, :integer)
      field(:live_inning_number, :integer)
      field(:presquad_time, :string)
      field(:verify_time, :string)
      field(:match_dls_affected, :string)
      field(:toss_decision_verify, :string)
      field(:toss_winner_verify, :string)
      field(:result_type_verify, :string)
      field(:player_of_the_match_verify, :string)
      # test format: Day-1 .. Day-5 / Session-1 .. Session-3
      field(:day, :string)
      field(:session, :string)
      field(:oddstype, :string)
      field(:session_odds_available, :boolean)
      embeds_one(:weather, EntitySports.Model.Weather)
      embeds_one(:pitch, EntitySports.Model.Pitch)
      embeds_one(:toss, EntitySports.Model.Toss)
    end
  end
end
