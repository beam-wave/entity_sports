defmodule EntitySports.Client do
  @moduledoc """
  EntitySports Cricket API V2 entry point.

  Delegates to the module configured under `:client_module`
  (`EntitySports.HTTPClient` by default, `EntitySports.Stub` in tests).
  See `EntitySports` for the documentation of each function.
  """

  @behaviour EntitySports
  @client_module Application.compile_env(:entity_sports, :client_module, EntitySports.HTTPClient)

  ## Seasons

  @impl true
  defdelegate seasons, to: @client_module

  @impl true
  defdelegate season_competitions(season_id, opts \\ []), to: @client_module

  ## Competitions

  @impl true
  defdelegate competitions(status, page, size), to: @client_module

  @impl true
  defdelegate competition(competition_id), to: @client_module

  @impl true
  defdelegate competition_matches(competition_id, opts \\ []), to: @client_module

  @impl true
  defdelegate competition_teams(competition_id), to: @client_module

  @impl true
  defdelegate competition_squads(competition_id), to: @client_module

  @impl true
  defdelegate competition_standings(competition_id), to: @client_module

  @impl true
  defdelegate competition_stat_types(competition_id), to: @client_module

  @impl true
  defdelegate competition_stats(competition_id, stat_type, opts \\ []), to: @client_module

  ## Matches

  @impl true
  defdelegate matches(status, start_date, end_date, page, size), to: @client_module

  @impl true
  defdelegate matches(opts), to: @client_module

  @impl true
  defdelegate match(match_id), to: @client_module

  @impl true
  defdelegate match(match_id, opts), to: @client_module

  @impl true
  defdelegate match_scorecard(match_id), to: @client_module

  @impl true
  defdelegate match_innings_commentary(match_id, inning_number), to: @client_module

  @impl true
  defdelegate match_live(match_id), to: @client_module

  @impl true
  defdelegate match_squads(match_id), to: @client_module

  @impl true
  defdelegate match_statistics(match_id), to: @client_module

  @impl true
  defdelegate match_wagons(match_id), to: @client_module

  ## Players

  @impl true
  defdelegate players(opts \\ []), to: @client_module

  @impl true
  defdelegate player(player_id), to: @client_module

  @impl true
  defdelegate player_stats(player_id), to: @client_module

  @impl true
  defdelegate player_statstic(player_id), to: @client_module

  ## Teams

  @impl true
  defdelegate team(team_id), to: @client_module

  @impl true
  defdelegate team_matches(team_id, opts \\ []), to: @client_module

  @impl true
  defdelegate team_players(team_id), to: @client_module

  ## Stand alone

  @impl true
  defdelegate icc_ranks, to: @client_module
end
