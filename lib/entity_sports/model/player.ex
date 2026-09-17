defmodule EntitySports.Model.Player do
  @moduledoc """
  Player model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:pid, :integer)
    field(:title, :string)
    field(:short_name, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:middle_name, :string)
    field(:birthdate, :string)
    field(:birthplace, :string)
    # Country ISO Code
    field(:country, :string)
    field(:primary_team, Raw)
    field(:thumb_url, :string)
    field(:logo_url, :string)
    # bat, bowl, all, wk, wkbat
    field(:playing_role, :string)
    field(:batting_style, :string)
    field(:bowling_style, :string)
    field(:fielding_position, :string)
    # match id of last played match
    field(:recent_match, :integer)
    # timestamp of last played match
    field(:recent_appearance, :integer)
    # fantasy salary or credit rating
    field(:fantasy_player_rating, Number)
    field(:alt_name, :string)
    field(:facebook_profile, :string)
    field(:twitter_profile, :string)
    field(:instagram_profile, :string)
    field(:debut_data, :string)
    field(:nationality, :string)
    # match squad role (scorecard / live players): bat, bowl, all, wk, cap, wkcap, squad
    field(:role, :string)
    field(:role_str, :string)
  end
end
