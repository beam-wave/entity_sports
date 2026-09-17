defmodule EntitySports.HTTPClient do
  @moduledoc """
  EntitySports Cricket API V2 HTTP client.

  Configuration (runtime):

      config :entity_sports,
        base_url: "https://rest.entitysport.com",
        url_prefix: "/v2",
        token: "..."
  """
  @behaviour EntitySports

  alias EntitySports.Constants
  alias EntitySports.Model.Responses
  alias EntitySports.Utils

  require Logger

  ## Seasons

  @impl true
  def seasons, do: get("/seasons", [], &Responses.Seasons.render_many/1)

  @impl true
  def season_competitions(season_id, opts),
    do:
      get(
        "/seasons/#{season_id}/competitions",
        Utils.page_params(opts),
        &Responses.Competitions.render_many/1
      )

  ## Competitions

  @impl true
  def competitions(status, page, size) do
    params = [status: Constants.competition_status(status), paged: page, per_page: size]
    get("/competitions", params, &Responses.Competitions.render_many/1)
  end

  @impl true
  def competition(competition_id),
    do: get("/competitions/#{competition_id}", [], &Responses.CompetitionOverview.render/1)

  @impl true
  def competition_matches(competition_id, opts),
    do:
      get(
        "/competitions/#{competition_id}/matches",
        Utils.page_params(opts),
        &Responses.Match.render_many/1
      )

  @impl true
  def competition_teams(competition_id),
    do: get("/competitions/#{competition_id}/teams", [], &Responses.CompetitionTeams.render/1)

  @impl true
  def competition_squads(competition_id),
    do: get("/competitions/#{competition_id}/squads", [], &Responses.CompetitionSquads.render/1)

  @impl true
  def competition_standings(competition_id),
    do:
      get(
        "/competitions/#{competition_id}/standings",
        [],
        &Responses.CompetitionStandings.render/1
      )

  @impl true
  def competition_stat_types(competition_id),
    do: get("/competitions/#{competition_id}/stats", [], &Responses.CompetitionStats.render/1)

  @impl true
  def competition_stats(competition_id, stat_type, opts) do
    params = [format: opts[:format]] ++ Utils.page_params(opts)

    get(
      "/competitions/#{competition_id}/stats/#{stat_type}",
      params,
      &Responses.CompetitionStats.render/1
    )
  end

  ## Matches

  @impl true
  def matches(status, start_date, end_date, page, size),
    do:
      matches(
        status: status,
        start_date: start_date,
        end_date: end_date,
        page: page,
        per_page: size
      )

  @impl true
  def matches(opts),
    do: get("/matches", Utils.match_filters(opts), &Responses.Match.render_many/1)

  @impl true
  def match(match_id), do: match(match_id, [])

  @impl true
  def match(match_id, opts) do
    params = [day: opts[:day], session: opts[:session]]
    get("/matches/#{match_id}/info", params, &Responses.Match.render/1)
  end

  @impl true
  def match_scorecard(match_id),
    do: get("/matches/#{match_id}/scorecard", [], &Responses.MatchScorecard.render/1)

  @impl true
  def match_innings_commentary(match_id, inning_number),
    do:
      get(
        "/matches/#{match_id}/innings/#{inning_number}/commentary",
        [],
        &Responses.MatchInningsCommentary.render/1
      )

  @impl true
  def match_live(match_id),
    do: get("/matches/#{match_id}/live", [], &Responses.MatchLive.render/1)

  @impl true
  def match_squads(match_id),
    do: get("/matches/#{match_id}/squads", [], &Responses.MatchSquads.render/1)

  @impl true
  def match_statistics(match_id),
    do: get("/matches/#{match_id}/statistics", [], &Responses.MatchStatistics.render/1)

  @impl true
  def match_wagons(match_id),
    do: get("/matches/#{match_id}/wagons", [], &Responses.MatchWagons.render/1)

  ## Players

  @impl true
  def players(opts) do
    params = [country: opts[:country], search: opts[:search]] ++ Utils.page_params(opts)
    get("/players", params, &Responses.Players.render_many/1)
  end

  @impl true
  def player(player_id), do: get("/players/#{player_id}", [], &Responses.PlayerProfile.render/1)

  @impl true
  def player_stats(player_id),
    do: get("/players/#{player_id}/stats", [], &Responses.PlayerStats.render/1)

  @impl true
  def player_statstic(player_id), do: player_stats(player_id)

  ## Teams

  @impl true
  def team(team_id), do: get("/teams/#{team_id}", [], &Responses.Team.render/1)

  @impl true
  def team_matches(team_id, opts) do
    params = [status: Utils.match_status(opts[:status])] ++ Utils.page_params(opts)
    get("/teams/#{team_id}/matches", params, &Responses.Match.render_many/1)
  end

  @impl true
  def team_players(team_id),
    do: get("/teams/#{team_id}/player", [], &Responses.TeamPlayers.render/1)

  ## Stand alone

  @impl true
  def icc_ranks, do: get("/iccranks", [], &Responses.IccRanks.render/1)

  ## Internals

  @doc false
  def get(path, params, render) do
    url = Utils.build_url(base_url(), path, [token: token()] ++ params)

    url
    |> Utils.get()
    |> Utils.deserialize_response(render)
  end

  defp base_url do
    Application.get_env(:entity_sports, :base_url, "https://rest.entitysport.com") <>
      Application.get_env(:entity_sports, :url_prefix, "/v2")
  end

  defp token, do: Application.fetch_env!(:entity_sports, :token)
end
