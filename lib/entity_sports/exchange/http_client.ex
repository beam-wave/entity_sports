defmodule EntitySports.Exchange.HTTPClient do
  @moduledoc """
  EntitySports Cricket Exchange API HTTP client.

  Configuration (runtime):

      config :entity_sports,
        base_url: "https://rest.entitysport.com",
        exchange_token: "..."
  """
  @behaviour EntitySportsExchange

  alias EntitySports.Constants
  alias EntitySports.Model.Responses
  alias EntitySports.Utils

  require Logger

  ## Competitions

  @impl true
  def e_competitions(opts) do
    params =
      [status: Constants.competition_status(opts[:status]), yearmonth: opts[:yearmonth]] ++
        Utils.page_params(opts)

    get("/competitions", params, &Responses.Competitions.render_many/1)
  end

  @impl true
  def e_competition(competition_id),
    do: get("/competitions/#{competition_id}/info", [], &Responses.CompetitionOverview.render/1)

  @impl true
  def e_competition_matches(competition_id, opts),
    do:
      get(
        "/competitions/#{competition_id}/matches",
        Utils.page_params(opts),
        &Responses.Match.render_many/1
      )

  @impl true
  def e_competition_squads(competition_id),
    do: get("/competitions/#{competition_id}/squads", [], &Responses.CompetitionSquads.render/1)

  @impl true
  def e_competition_stat_types(competition_id),
    do: get("/competitions/#{competition_id}/stats", [], &Responses.CompetitionStats.render/1)

  @impl true
  def e_competition_stats(competition_id, stat_type, opts) do
    params = [format: opts[:format]] ++ Utils.page_params(opts)

    get(
      "/competitions/#{competition_id}/stats/#{stat_type}",
      params,
      &Responses.CompetitionStats.render/1
    )
  end

  ## Matches

  @impl true
  def e_matches(status, start_date, end_date, page, size),
    do:
      e_matches(
        status: status,
        start_date: start_date,
        end_date: end_date,
        page: page,
        per_page: size
      )

  @impl true
  def e_matches(opts),
    do: get("/matches", Utils.match_filters(opts), &Responses.Match.render_many/1)

  @impl true
  def e_match(match_id), do: get("/matches/#{match_id}/info", [], &Responses.MatchInfo.render/1)

  @impl true
  def e_match_odds(match_id),
    do: get("/matches/#{match_id}/odds", [], &Responses.MatchOdds.render/1)

  @impl true
  def e_multi_match_odds(match_ids),
    do: get("/matchesmultiodds", [match_id: match_ids], &Responses.MultiMatchOdds.render/1)

  @impl true
  def e_settle_match_odds(match_id), do: e_settle_match_odds(match_id, [])

  @impl true
  def e_settle_match_odds(match_id, opts) do
    params = [
      filter_type: opts[:filter_type],
      filter: opts[:filter],
      status: Utils.match_status(opts[:status])
    ]

    get("/matches/#{match_id}/settleodds", params, &Responses.SettleMatchOdds.render_many/1)
  end

  @impl true
  def e_match_innings_commentary(match_id, inning_number),
    do:
      get(
        "/matches/#{match_id}/innings/#{inning_number}/commentary",
        [],
        &Responses.MatchInningsCommentary.render/1
      )

  @impl true
  def e_match_statistics(match_id),
    do: get("/matches/#{match_id}/statistics", [], &Responses.MatchStatistics.render/1)

  @impl true
  def e_match_wagons(match_id),
    do: get("/matches/#{match_id}/wagons", [], &Responses.MatchWagons.render/1)

  @impl true
  def e_match_ball_event(match_id),
    do: get("/matches/#{match_id}/ballevent", [], &Responses.BallEvent.render/1)

  ## Rounds

  @impl true
  def e_round_matches(round_id, opts),
    do:
      get(
        "/rounds/#{round_id}/matches",
        Utils.page_params(opts),
        &Responses.RoundMatches.render/1
      )

  @impl true
  def e_round_teams(round_id),
    do: get("/rounds/#{round_id}/teams", [], &Responses.CompetitionTeams.render/1)

  ## Teams

  @impl true
  def e_teams(opts),
    do:
      get(
        "/teams",
        [search: opts[:search]] ++ Utils.page_params(opts),
        &Responses.Team.render_many/1
      )

  @impl true
  def e_team(team_id), do: get("/teams/#{team_id}", [], &Responses.Team.render/1)

  @impl true
  def e_team_matches(team_id, opts) do
    params = [status: Utils.match_status(opts[:status])] ++ Utils.page_params(opts)
    get("/teams/#{team_id}/matches", params, &Responses.Match.render_many/1)
  end

  @impl true
  def e_team_players(team_id),
    do: get("/teams/#{team_id}/player", [], &Responses.TeamPlayers.render/1)

  ## Players

  @impl true
  def e_players(opts) do
    params = [country: opts[:country], search: opts[:search]] ++ Utils.page_params(opts)
    get("/players", params, &Responses.Players.render_many/1)
  end

  @impl true
  def e_player(player_id), do: get("/players/#{player_id}", [], &Responses.PlayerProfile.render/1)

  @impl true
  def e_player_stats(player_id),
    do: get("/players/#{player_id}/stats", [], &Responses.PlayerStats.render/1)

  ## Stand alone

  @impl true
  def e_icc_ranks, do: get("/iccranks", [], &Responses.IccRanks.render/1)

  ## Internals

  defp get(path, params, render) do
    url = Utils.build_url(base_url(), path, [token: token()] ++ params)

    url
    |> Utils.get()
    |> Utils.deserialize_response(render)
  end

  defp base_url do
    Application.get_env(:entity_sports, :base_url, "https://rest.entitysport.com") <>
      Application.get_env(:entity_sports, :exchange_url_prefix, "/exchange")
  end

  defp token, do: Application.fetch_env!(:entity_sports, :exchange_token)
end
