defmodule EntitySports.Exchange.Stub do
  @moduledoc """
  EntitySports Cricket Exchange API stub. Returns the sample payloads shipped
  in `priv/fixtures/exchange`, rendered through the real response models.
  """
  @behaviour EntitySportsExchange

  alias EntitySports.Fixtures
  alias EntitySports.Model.Responses

  @impl true
  def e_competitions(_opts),
    do: Fixtures.render(:exchange, :competitions, &Responses.Competitions.render_many/1)

  @impl true
  def e_competition(_competition_id),
    do: Fixtures.render(:exchange, :competition, &Responses.CompetitionOverview.render/1)

  @impl true
  def e_competition_matches(_competition_id, _opts),
    do: Fixtures.render(:exchange, :competition_matches, &Responses.Match.render_many/1)

  @impl true
  def e_competition_squads(_competition_id),
    do: Fixtures.render(:exchange, :competition_squads, &Responses.CompetitionSquads.render/1)

  @impl true
  def e_competition_stat_types(_competition_id),
    do: Fixtures.render(:exchange, :competition_stat_types, &Responses.CompetitionStats.render/1)

  @impl true
  def e_competition_stats(_competition_id, _stat_type, _opts),
    do: Fixtures.render(:exchange, :competition_stats, &Responses.CompetitionStats.render/1)

  @impl true
  def e_matches(_status, _start_date, _end_date, _page, _size), do: e_matches([])

  @impl true
  def e_matches(_opts), do: Fixtures.render(:exchange, :matches, &Responses.Match.render_many/1)

  @impl true
  def e_match(_match_id), do: Fixtures.render(:exchange, :match, &Responses.MatchInfo.render/1)

  @impl true
  def e_match_odds(_match_id),
    do: Fixtures.render(:exchange, :match_odds, &Responses.MatchOdds.render/1)

  @impl true
  def e_multi_match_odds(_match_ids),
    do: Fixtures.render(:exchange, :multi_match_odds, &Responses.MultiMatchOdds.render/1)

  @impl true
  def e_settle_match_odds(_match_id),
    do: Fixtures.render(:exchange, :settle_match_odds, &Responses.SettleMatchOdds.render_many/1)

  @impl true
  def e_settle_match_odds(match_id, _opts), do: e_settle_match_odds(match_id)

  @impl true
  def e_match_innings_commentary(_match_id, _inning_number),
    do:
      Fixtures.render(
        :exchange,
        :match_innings_commentary,
        &Responses.MatchInningsCommentary.render/1
      )

  @impl true
  def e_match_statistics(_match_id),
    do: Fixtures.render(:exchange, :match_statistics, &Responses.MatchStatistics.render/1)

  @impl true
  def e_match_wagons(_match_id),
    do: Fixtures.render(:exchange, :match_wagons, &Responses.MatchWagons.render/1)

  @impl true
  def e_match_ball_event(_match_id),
    do: Fixtures.render(:exchange, :match_ball_event, &Responses.BallEvent.render/1)

  @impl true
  def e_round_matches(_round_id, _opts),
    do: Fixtures.render(:exchange, :round_matches, &Responses.RoundMatches.render/1)

  @impl true
  def e_round_teams(_round_id),
    do: Fixtures.render(:exchange, :round_teams, &Responses.CompetitionTeams.render/1)

  @impl true
  def e_teams(_opts), do: Fixtures.render(:exchange, :teams, &Responses.Team.render_many/1)

  @impl true
  def e_team(_team_id), do: Fixtures.render(:exchange, :team, &Responses.Team.render/1)

  @impl true
  def e_team_matches(_team_id, _opts),
    do: Fixtures.render(:exchange, :team_matches, &Responses.Match.render_many/1)

  @impl true
  def e_team_players(_team_id),
    do: Fixtures.render(:exchange, :team_players, &Responses.TeamPlayers.render/1)

  @impl true
  def e_players(_opts), do: Fixtures.render(:exchange, :players, &Responses.Players.render_many/1)

  @impl true
  def e_player(_player_id),
    do: Fixtures.render(:exchange, :player, &Responses.PlayerProfile.render/1)

  @impl true
  def e_player_stats(_player_id),
    do: Fixtures.render(:exchange, :player_stats, &Responses.PlayerStats.render/1)

  @impl true
  def e_icc_ranks, do: Fixtures.render(:exchange, :icc_ranks, &Responses.IccRanks.render/1)
end
