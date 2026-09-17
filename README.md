# EntitySports

Elixir SDK for the [EntitySport](https://www.doc.entitysport.com) **Cricket API V2**
and **Cricket Exchange** REST APIs. Every documented endpoint is exposed as a
function returning typed structs (Ecto embedded schemas).

## Installation

```elixir
def deps do
  [
    {:entity_sports, "~> 1.1.0"}
  ]
end
```

## Configuration

```elixir
# config/config.exs (compile time - picks the implementation)
config :entity_sports,
  client_module: EntitySports.HTTPClient,
  exchange_client_module: EntitySports.Exchange.HTTPClient

# config/runtime.exs
config :entity_sports,
  base_url: "https://rest.entitysport.com",
  url_prefix: "/v2",                # "/sandbox/cricket" for the sandbox
  exchange_url_prefix: "/exchange",
  token: System.fetch_env!("ENTITY_SPORTS_TOKEN"),
  exchange_token: System.fetch_env!("ENTITY_SPORTS_EXCHANGE_TOKEN"),
  http_client_opts: [timeout: 50_000, recv_timeout: 50_000]

# config/test.exs - stubs backed by sample payloads in priv/fixtures
config :entity_sports,
  client_module: EntitySports.Stub,
  exchange_client_module: EntitySports.Exchange.Stub
```

## Usage

```elixir
alias EntitySports.Client
alias EntitySports.Exchange.Client, as: Exchange

{:ok, seasons, total_pages, total_items} = Client.seasons()
{:ok, matches, _, _} = Client.matches(status: :live, format: :t20, page: 1, per_page: 50)
{:ok, %EntitySports.Model.Responses.Match{} = match} = Client.match(63951)
{:ok, scorecard} = Client.match_scorecard(63951)
{:ok, live} = Client.match_live(63951)

{:ok, info} = Exchange.e_match(63951)          # match info + playing 11 + scorecard + live + odds
{:ok, odds} = Exchange.e_match_odds(63951)
{:ok, multi} = Exchange.e_multi_match_odds([77363, 83678])
```

Return shapes:

* `{:ok, struct}` for single objects
* `{:ok, items, total_pages, total_items}` for lists (page counters are `nil`
  when the endpoint does not paginate)
* `{:error, %Ecto.Changeset{}, raw_response}` when the payload could not be cast
* `{:error, http_status, body}` for HTTP / API errors

Every response struct keeps the decoded payload under `raw_response`.
Optional parameters go in a keyword list: `:page`, `:per_page`, `:status`,
`:format`, `:date` / `:start_date` + `:end_date`, `:timezone`, `:country`,
`:search`, ... (see the `@callback` docs in `EntitySports` and
`EntitySportsExchange`). Status / format atoms are mapped to API codes by
`EntitySports.Constants`.

## Endpoint coverage

### Cricket API V2 (`EntitySports.Client`)

| Function | Endpoint |
| --- | --- |
| `seasons/0` | `/seasons` |
| `season_competitions/2` | `/seasons/:sid/competitions` |
| `competitions/3` | `/competitions` |
| `competition/1` | `/competitions/:cid` |
| `competition_matches/2` | `/competitions/:cid/matches` |
| `competition_teams/1` | `/competitions/:cid/teams` |
| `competition_squads/1` | `/competitions/:cid/squads` |
| `competition_standings/1` | `/competitions/:cid/standings` |
| `competition_stat_types/1` | `/competitions/:cid/stats` |
| `competition_stats/3` | `/competitions/:cid/stats/:stat_type` |
| `matches/1`, `matches/5` | `/matches` |
| `match/1`, `match/2` | `/matches/:mid/info` |
| `match_scorecard/1` | `/matches/:mid/scorecard` |
| `match_innings_commentary/2` | `/matches/:mid/innings/:n/commentary` |
| `match_live/1` | `/matches/:mid/live` |
| `match_squads/1` | `/matches/:mid/squads` |
| `match_statistics/1` | `/matches/:mid/statistics` |
| `match_wagons/1` | `/matches/:mid/wagons` |
| `players/1` | `/players` |
| `player/1` | `/players/:pid` |
| `player_stats/1` (`player_statstic/1`) | `/players/:pid/stats` |
| `team/1` | `/teams/:tid` |
| `team_matches/2` | `/teams/:tid/matches` |
| `team_players/1` | `/teams/:tid/player` |
| `icc_ranks/0` | `/iccranks` |

### Cricket Exchange (`EntitySports.Exchange.Client`)

| Function | Endpoint |
| --- | --- |
| `e_competitions/1` | `/competitions` |
| `e_competition/1` | `/competitions/:cid/info` |
| `e_competition_matches/2` | `/competitions/:cid/matches` |
| `e_competition_squads/1` | `/competitions/:cid/squads` |
| `e_competition_stat_types/1` | `/competitions/:cid/stats` |
| `e_competition_stats/3` | `/competitions/:cid/stats/:stat_type` |
| `e_matches/1`, `e_matches/5` | `/matches` |
| `e_match/1` | `/matches/:mid/info` |
| `e_match_odds/1` | `/matches/:mid/odds` |
| `e_multi_match_odds/1` | `/matchesmultiodds` |
| `e_settle_match_odds/1`, `e_settle_match_odds/2` | `/matches/:mid/settleodds` |
| `e_match_innings_commentary/2` | `/matches/:mid/innings/:n/commentary` |
| `e_match_statistics/1` | `/matches/:mid/statistics` |
| `e_match_wagons/1` | `/matches/:mid/wagons` |
| `e_match_ball_event/1` | `/matches/:mid/ballevent` |
| `e_round_matches/2` | `/rounds/:rid/matches` |
| `e_round_teams/1` | `/rounds/:rid/teams` |
| `e_teams/1` | `/teams` |
| `e_team/1` | `/teams/:tid` |
| `e_team_matches/2` | `/teams/:tid/matches` |
| `e_team_players/1` | `/teams/:tid/player` |
| `e_players/1` | `/players` |
| `e_player/1` | `/players/:pid` |
| `e_player_stats/1` | `/players/:pid/stats` |
| `e_icc_ranks/0` | `/iccranks` |

Push / websocket delivery (`ws://webhook.entitysport.com:8087/connect?token=`)
sends the same payload as `e_match/1`; decode it with
`EntitySports.Model.Responses.MatchInfo.render/1`.

## Development

```
mix test      # renders every fixture in priv/fixtures through the models
mix docs
```
