defmodule EntitySports do
  @moduledoc """
  EntitySports Cricket API V2 interface.

  Every function returns `{:ok, result}` (or `{:ok, items, total_pages, total_items}`
  for paginated lists) or an error tuple:

    * `{:error, %Ecto.Changeset{}, raw_response}` - payload could not be cast
    * `{:error, http_status, body}` - HTTP or API level error (`status: "error"`)

  Optional query parameters are passed as a keyword list (`opts`). Common keys:

    * `:page` / `:per_page` - pagination
    * `:status` - match status (`:scheduled | :completed | :live | :abandoned` or code)
    * `:format` - match format (see `EntitySports.Constants.format/1`)

  See https://www.doc.entitysport.com (Cricket API V2).
  """

  alias EntitySports.Model
  alias EntitySports.Model.Responses

  @type error :: {:error, Ecto.Changeset.t(), map()} | {:error, integer(), any()}
  @type match_status :: :scheduled | :completed | :live | :abandoned | :canceled | :no_result
  @type competition_status :: :fixture | :result | :live
  @type page(item) ::
          {:ok, [item], total_pages :: integer() | nil, total_items :: integer() | nil}
  @type opts :: keyword()

  ## Seasons

  @doc """
  Seasons API - `GET /v2/seasons`

  Lists all cricket seasons you have access to. A season is named as a
  complete year (`2016`) or a cross year (`2016-17`).
  """
  @callback seasons() :: page(Responses.Seasons.t()) | error

  @doc """
  Season Competitions API - `GET /v2/seasons/[sid]/competitions`

  Lists competitions of a season. Opts: `:page`, `:per_page`.
  """
  @callback season_competitions(season_id :: String.t() | integer(), opts) ::
              page(Responses.Competitions.t()) | error

  ## Competitions

  @doc """
  Competitions List API - `GET /v2/competitions`

  Lists all competitions you are subscribed to, filtered by status
  (`:fixture` upcoming, `:result` completed, `:live` ongoing).
  """
  @callback competitions(
              status :: competition_status() | nil,
              page :: integer(),
              size :: integer()
            ) ::
              page(Responses.Competitions.t()) | error

  @doc """
  Competitions Overview API - `GET /v2/competitions/[cid]`
  """
  @callback competition(competition_id :: integer()) ::
              {:ok, Responses.CompetitionOverview.t()} | error

  @doc """
  Competition Matches API - `GET /v2/competitions/[cid]/matches`

  Lists scheduled, live and completed matches of a competition.
  Opts: `:page`, `:per_page`.
  """
  @callback competition_matches(competition_id :: integer(), opts) ::
              page(Responses.Match.t()) | error

  @doc """
  Competition Teams API - `GET /v2/competitions/[cid]/teams`
  """
  @callback competition_teams(competition_id :: integer()) ::
              {:ok, Responses.CompetitionTeams.t()} | error

  @doc """
  Competition Squads API - `GET /v2/competitions/[cid]/squads`

  Player roster of every participating team. `squad_type` is `per_match`
  (international tours) or `per_team` (tournaments).
  """
  @callback competition_squads(competition_id :: integer()) ::
              {:ok, Responses.CompetitionSquads.t()} | error

  @doc """
  Competition Standings API - `GET /v2/competitions/[cid]/standings`
  """
  @callback competition_standings(competition_id :: integer()) ::
              {:ok, Responses.CompetitionStandings.t()} | error

  @doc """
  Competition Statistic Type API - `GET /v2/competitions/[cid]/stats`

  Lists the statistic types (`stat_types`) and formats available for the
  competition.
  """
  @callback competition_stat_types(competition_id :: integer()) ::
              {:ok, Responses.CompetitionStats.t()} | error

  @doc """
  Competition Statistic API - `GET /v2/competitions/[cid]/stats/[stat_type]`

  `stat_type` i.e. `"batting_most_runs"`, `"bowling_top_wicket_takers"`,
  `"team_total_runs"` (see `competition_stat_types/1`).
  Opts: `:format`, `:page`, `:per_page`.
  """
  @callback competition_stats(competition_id :: integer(), stat_type :: String.t(), opts) ::
              {:ok, Responses.CompetitionStats.t()} | error

  ## Matches

  @doc """
  Matches List API - `GET /v2/matches`

  Lists matches by status within a date range (`yyyy-mm-dd`).
  """
  @callback matches(
              status :: match_status() | integer() | nil,
              start_date :: String.t(),
              end_date :: String.t(),
              page :: integer(),
              size :: integer()
            ) :: page(Responses.Match.t()) | error

  @doc """
  Matches List API - `GET /v2/matches`

  Opts: `:status`, `:format`, `:date` (`"yyyy-mm-dd_yyyy-mm-dd"`) or
  `:start_date` + `:end_date`, `:timezone` (`"+5:30"`), `:pre_squad`,
  `:day`, `:session`, `:page`, `:per_page`.
  """
  @callback matches(opts) :: page(Responses.Match.t()) | error

  @doc """
  Match Info API - `GET /v2/matches/[mid]/info`
  """
  @callback match(match_id :: integer()) :: {:ok, Responses.Match.t()} | error

  @doc """
  Match Info API - `GET /v2/matches/[mid]/info`

  Opts: `:day`, `:session` (test / first class matches).
  """
  @callback match(match_id :: integer(), opts) :: {:ok, Responses.Match.t()} | error

  @doc """
  Match Scorecard API - `GET /v2/matches/[mid]/scorecard`

  Full scorecard: batting, bowling, fall of wickets, venue, umpires, toss.
  """
  @callback match_scorecard(match_id :: integer()) :: {:ok, Responses.MatchScorecard.t()} | error

  @doc """
  Match Innings Commentary API - `GET /v2/matches/[mid]/innings/[number]/commentary`

  Ball by ball commentary of a single inning.
  """
  @callback match_innings_commentary(match_id :: integer(), inning_number :: integer()) ::
              {:ok, Responses.MatchInningsCommentary.t()} | error

  @doc """
  Match Live API - `GET /v2/matches/[mid]/live`

  Fastest updates of the active inning.
  """
  @callback match_live(match_id :: integer()) :: {:ok, Responses.MatchLive.t()} | error

  @doc """
  Match Playing11 API - `GET /v2/matches/[mid]/squads`
  """
  @callback match_squads(match_id :: integer()) :: {:ok, Responses.MatchSquads.t()} | error

  @doc """
  Match Statistics API - `GET /v2/matches/[mid]/statistics`

  Manhattan, worm, partnership, run types, player vs player, wickets and
  run rate per inning.
  """
  @callback match_statistics(match_id :: integer()) ::
              {:ok, Responses.MatchStatistics.t()} | error

  @doc """
  Match Wagon Wheel API - `GET /v2/matches/[mid]/wagons`
  """
  @callback match_wagons(match_id :: integer()) :: {:ok, Responses.MatchWagons.t()} | error

  ## Players

  @doc """
  Player Search API - `GET /v2/players`

  Opts: `:country` (2 letter ISO code), `:search` (name), `:page`, `:per_page`.
  """
  @callback players(opts) :: page(Model.Player.t()) | error

  @doc """
  Player Profile API - `GET /v2/players/[pid]`
  """
  @callback player(player_id :: integer()) :: {:ok, Responses.PlayerProfile.t()} | error

  @doc """
  Player Statistic API - `GET /v2/players/[pid]/stats`
  """
  @callback player_stats(player_id :: integer()) :: {:ok, Responses.PlayerStats.t()} | error

  @doc "Alias of `player_stats/1` (kept for backward compatibility)."
  @callback player_statstic(player_id :: integer()) :: {:ok, Responses.PlayerStats.t()} | error

  ## Teams

  @doc """
  Team API - `GET /v2/teams/[tid]`
  """
  @callback team(team_id :: integer()) :: {:ok, Responses.Team.t()} | error

  @doc """
  Team Matches API - `GET /v2/teams/[tid]/matches`

  Opts: `:status`, `:page`, `:per_page`.
  """
  @callback team_matches(team_id :: integer(), opts) :: page(Responses.Match.t()) | error

  @doc """
  Team Players API - `GET /v2/teams/[tid]/player`

  Players grouped by format.
  """
  @callback team_players(team_id :: integer()) :: {:ok, Responses.TeamPlayers.t()} | error

  ## Stand alone

  @doc """
  ICC Ranking API - `GET /v2/iccranks`
  """
  @callback icc_ranks() :: {:ok, Responses.IccRanks.t()} | error
end
