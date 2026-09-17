defmodule EntitySportsExchange do
  @moduledoc """
  EntitySports Cricket Exchange API interface.

  Same conventions as `EntitySports`; every function is prefixed with `e_`.
  Weather, match notes, detailed commentary and pitch conditions require the
  Cricket Exchange Gold plan or above. Settle odds require a premium plan.

  See https://www.doc.entitysport.com (Cricket Exchange).
  """

  alias EntitySports.Model
  alias EntitySports.Model.Responses

  @type error :: {:error, Ecto.Changeset.t(), map()} | {:error, integer(), any()}
  @type match_status :: :scheduled | :completed | :live | :abandoned | :canceled | :no_result
  @type competition_status :: :fixture | :result | :live
  @type page(item) ::
          {:ok, [item], total_pages :: integer() | nil, total_items :: integer() | nil}
  @type opts :: keyword()

  ## Competitions

  @doc """
  Competitions List API - `GET /exchange/competitions`

  Opts: `:status` (`:fixture | :result | :live`), `:yearmonth` (`"2018-02"`),
  `:page`, `:per_page`.
  """
  @callback e_competitions(opts) :: page(Responses.Competitions.t()) | error

  @doc """
  Competitions Information API - `GET /exchange/competitions/[cid]/info`
  """
  @callback e_competition(competition_id :: integer()) ::
              {:ok, Responses.CompetitionOverview.t()} | error

  @doc """
  Competition Matches API - `GET /exchange/competitions/[cid]/matches`

  Opts: `:page`, `:per_page`.
  """
  @callback e_competition_matches(competition_id :: integer(), opts) ::
              page(Responses.Match.t()) | error

  @doc """
  Competition Squads API - `GET /exchange/competitions/[cid]/squads`
  """
  @callback e_competition_squads(competition_id :: integer()) ::
              {:ok, Responses.CompetitionSquads.t()} | error

  @doc """
  Competition Statistic Type API - `GET /exchange/competitions/[cid]/stats`
  """
  @callback e_competition_stat_types(competition_id :: integer()) ::
              {:ok, Responses.CompetitionStats.t()} | error

  @doc """
  Competition Statistic API - `GET /exchange/competitions/[cid]/stats/[stat_type]`

  Opts: `:format`, `:page`, `:per_page`.
  """
  @callback e_competition_stats(competition_id :: integer(), stat_type :: String.t(), opts) ::
              {:ok, Responses.CompetitionStats.t()} | error

  ## Matches

  @doc """
  Matches List API - `GET /exchange/matches`
  """
  @callback e_matches(
              status :: match_status() | integer() | nil,
              start_date :: String.t(),
              end_date :: String.t(),
              page :: integer(),
              size :: integer()
            ) :: page(Responses.Match.t()) | error

  @doc """
  Matches List API - `GET /exchange/matches`

  Opts: `:status`, `:format`, `:date` or `:start_date` + `:end_date`,
  `:timezone`, `:pre_squad`, `:day`, `:session`, `:page`, `:per_page`.
  """
  @callback e_matches(opts) :: page(Responses.Match.t()) | error

  @doc """
  Match Info API - `GET /exchange/matches/[mid]/info`

  Match info, playing 11, notes, scorecard, live state, live odds and
  session odds in one payload. This is also the payload delivered by the
  push / websocket feed.
  """
  @callback e_match(match_id :: integer()) :: {:ok, Responses.MatchInfo.t()} | error

  @doc """
  Match Odds API - `GET /exchange/matches/[mid]/odds`
  """
  @callback e_match_odds(match_id :: integer()) :: {:ok, Responses.MatchOdds.t()} | error

  @doc """
  Multiple Match Odds API - `GET /exchange/matchesmultiodds?match_id=1,2`
  """
  @callback e_multi_match_odds(match_ids :: [integer()]) ::
              {:ok, Responses.MultiMatchOdds.t()} | error

  @doc """
  Match Settle Odds API - `GET /exchange/matches/[mid]/settleodds` (premium)
  """
  @callback e_settle_match_odds(match_id :: integer()) ::
              page(Responses.SettleMatchOdds.t()) | error

  @doc """
  Match Settle Odds API - `GET /exchange/matches/[mid]/settleodds` (premium)

  Opts: `:filter_type` (`"over_range"`), `:filter`, `:status`.
  """
  @callback e_settle_match_odds(match_id :: integer(), opts) ::
              page(Responses.SettleMatchOdds.t()) | error

  @doc """
  Match Innings Commentary API - `GET /exchange/matches/[mid]/innings/[number]/commentary`
  """
  @callback e_match_innings_commentary(match_id :: integer(), inning_number :: integer()) ::
              {:ok, Responses.MatchInningsCommentary.t()} | error

  @doc """
  Match Statistics API - `GET /exchange/matches/[mid]/statistics`
  """
  @callback e_match_statistics(match_id :: integer()) ::
              {:ok, Responses.MatchStatistics.t()} | error

  @doc """
  Match Wagon Wheel API - `GET /exchange/matches/[mid]/wagons`
  """
  @callback e_match_wagons(match_id :: integer()) :: {:ok, Responses.MatchWagons.t()} | error

  @doc """
  Match Ball Event API - `GET /exchange/matches/[mid]/ballevent`

  Pre and after ball events (see Cricket Reference > Ball events).
  """
  @callback e_match_ball_event(match_id :: integer()) :: {:ok, Responses.BallEvent.t()} | error

  ## Rounds

  @doc """
  Rounds Matches API - `GET /exchange/rounds/[rid]/matches`

  Opts: `:page`, `:per_page`.
  """
  @callback e_round_matches(round_id :: integer(), opts) ::
              {:ok, Responses.RoundMatches.t()} | error

  @doc """
  Rounds Teams API - `GET /exchange/rounds/[rid]/teams`
  """
  @callback e_round_teams(round_id :: integer()) :: {:ok, Responses.CompetitionTeams.t()} | error

  ## Teams

  @doc """
  Team List API - `GET /exchange/teams`

  Opts: `:search`, `:page`, `:per_page`.
  """
  @callback e_teams(opts) :: page(Responses.Team.t()) | error

  @doc """
  Team API - `GET /exchange/teams/[tid]`
  """
  @callback e_team(team_id :: integer()) :: {:ok, Responses.Team.t()} | error

  @doc """
  Team Matches API - `GET /exchange/teams/[tid]/matches`

  Opts: `:status`, `:page`, `:per_page`.
  """
  @callback e_team_matches(team_id :: integer(), opts) :: page(Responses.Match.t()) | error

  @doc """
  Team Players API - `GET /exchange/teams/[tid]/player`
  """
  @callback e_team_players(team_id :: integer()) :: {:ok, Responses.TeamPlayers.t()} | error

  ## Players

  @doc """
  Player Search API - `GET /exchange/players`

  Opts: `:country`, `:search`, `:page`, `:per_page`.
  """
  @callback e_players(opts) :: page(Model.Player.t()) | error

  @doc """
  Player Profile API - `GET /exchange/players/[pid]`
  """
  @callback e_player(player_id :: integer()) :: {:ok, Responses.PlayerProfile.t()} | error

  @doc """
  Player Statistics API - `GET /exchange/players/[pid]/stats`
  """
  @callback e_player_stats(player_id :: integer()) :: {:ok, Responses.PlayerStats.t()} | error

  ## Stand alone

  @doc """
  ICC Ranking API - `GET /exchange/iccranks`
  """
  @callback e_icc_ranks() :: {:ok, Responses.IccRanks.t()} | error
end
