defmodule EntitySports.Stub do
  @moduledoc """
  EntitySports Cricket API V2 stub. Returns the sample payloads shipped in
  `priv/fixtures/v2`, rendered through the real response models.
  """
  @behaviour EntitySports

  alias EntitySports.Fixtures
  alias EntitySports.Model.Responses

  @impl true
  def seasons, do: Fixtures.render(:v2, :seasons, &Responses.Seasons.render_many/1)

  @impl true
  def season_competitions(_season_id, _opts),
    do: Fixtures.render(:v2, :season_competitions, &Responses.Competitions.render_many/1)

  @impl true
  def competitions(_status, _page, _size),
    do: Fixtures.render(:v2, :competitions, &Responses.Competitions.render_many/1)

  @impl true
  def competition(_competition_id),
    do: Fixtures.render(:v2, :competition, &Responses.CompetitionOverview.render/1)

  @impl true
  def competition_matches(_competition_id, _opts),
    do: Fixtures.render(:v2, :competition_matches, &Responses.Match.render_many/1)

  @impl true
  def competition_teams(_competition_id),
    do: Fixtures.render(:v2, :competition_teams, &Responses.CompetitionTeams.render/1)

  @impl true
  def competition_squads(_competition_id),
    do: Fixtures.render(:v2, :competition_squads, &Responses.CompetitionSquads.render/1)

  @impl true
  def competition_standings(_competition_id),
    do: Fixtures.render(:v2, :competition_standings, &Responses.CompetitionStandings.render/1)

  @impl true
  def competition_stat_types(_competition_id),
    do: Fixtures.render(:v2, :competition_stat_types, &Responses.CompetitionStats.render/1)

  @impl true
  def competition_stats(_competition_id, _stat_type, _opts),
    do: Fixtures.render(:v2, :competition_stats, &Responses.CompetitionStats.render/1)

  @impl true
  def matches(_status, _start_date, _end_date, _page, _size), do: matches([])

  @impl true
  def matches(_opts), do: Fixtures.render(:v2, :matches, &Responses.Match.render_many/1)

  @impl true
  def match(_match_id), do: Fixtures.render(:v2, :match, &Responses.Match.render/1)

  @impl true
  def match(match_id, _opts), do: match(match_id)

  @impl true
  def match_scorecard(_match_id),
    do: Fixtures.render(:v2, :match_scorecard, &Responses.MatchScorecard.render/1)

  @impl true
  def match_innings_commentary(_match_id, _inning_number),
    do:
      Fixtures.render(:v2, :match_innings_commentary, &Responses.MatchInningsCommentary.render/1)

  @impl true
  def match_live(_match_id), do: Fixtures.render(:v2, :match_live, &Responses.MatchLive.render/1)

  @impl true
  def match_squads(_match_id),
    do: Fixtures.render(:v2, :match_squads, &Responses.MatchSquads.render/1)

  @impl true
  def match_statistics(_match_id),
    do: Fixtures.render(:v2, :match_statistics, &Responses.MatchStatistics.render/1)

  @impl true
  def match_wagons(_match_id),
    do: Fixtures.render(:v2, :match_wagons, &Responses.MatchWagons.render/1)

  @impl true
  def players(_opts), do: Fixtures.render(:v2, :players, &Responses.Players.render_many/1)

  @impl true
  def player(_player_id), do: Fixtures.render(:v2, :player, &Responses.PlayerProfile.render/1)

  @impl true
  def player_stats(_player_id),
    do: Fixtures.render(:v2, :player_stats, &Responses.PlayerStats.render/1)

  @impl true
  def player_statstic(player_id), do: player_stats(player_id)

  @impl true
  def team(_team_id), do: Fixtures.render(:v2, :team, &Responses.Team.render/1)

  @impl true
  def team_matches(_team_id, _opts),
    do: Fixtures.render(:v2, :team_matches, &Responses.Match.render_many/1)

  @impl true
  def team_players(_team_id),
    do: Fixtures.render(:v2, :team_players, &Responses.TeamPlayers.render/1)

  @impl true
  def icc_ranks, do: Fixtures.render(:v2, :icc_ranks, &Responses.IccRanks.render/1)
end
