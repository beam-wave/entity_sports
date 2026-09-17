defmodule EntitySports.Exchange.Client do
  @moduledoc """
  EntitySports Cricket Exchange API entry point.

  Delegates to the module configured under `:exchange_client_module`
  (`EntitySports.Exchange.HTTPClient` by default, `EntitySports.Exchange.Stub`
  in tests). See `EntitySportsExchange` for the documentation of each function.
  """

  @behaviour EntitySportsExchange
  @client_module Application.compile_env(
                   :entity_sports,
                   :exchange_client_module,
                   EntitySports.Exchange.HTTPClient
                 )

  ## Competitions

  @impl true
  defdelegate e_competitions(opts \\ []), to: @client_module

  @impl true
  defdelegate e_competition(competition_id), to: @client_module

  @impl true
  defdelegate e_competition_matches(competition_id, opts \\ []), to: @client_module

  @impl true
  defdelegate e_competition_squads(competition_id), to: @client_module

  @impl true
  defdelegate e_competition_stat_types(competition_id), to: @client_module

  @impl true
  defdelegate e_competition_stats(competition_id, stat_type, opts \\ []), to: @client_module

  ## Matches

  @impl true
  defdelegate e_matches(status, start_date, end_date, page, size), to: @client_module

  @impl true
  defdelegate e_matches(opts), to: @client_module

  @impl true
  defdelegate e_match(match_id), to: @client_module

  @impl true
  defdelegate e_match_odds(match_id), to: @client_module

  @impl true
  defdelegate e_multi_match_odds(match_ids), to: @client_module

  @impl true
  defdelegate e_settle_match_odds(match_id), to: @client_module

  @impl true
  defdelegate e_settle_match_odds(match_id, opts), to: @client_module

  @impl true
  defdelegate e_match_innings_commentary(match_id, inning_number), to: @client_module

  @impl true
  defdelegate e_match_statistics(match_id), to: @client_module

  @impl true
  defdelegate e_match_wagons(match_id), to: @client_module

  @impl true
  defdelegate e_match_ball_event(match_id), to: @client_module

  ## Rounds

  @impl true
  defdelegate e_round_matches(round_id, opts \\ []), to: @client_module

  @impl true
  defdelegate e_round_teams(round_id), to: @client_module

  ## Teams

  @impl true
  defdelegate e_teams(opts \\ []), to: @client_module

  @impl true
  defdelegate e_team(team_id), to: @client_module

  @impl true
  defdelegate e_team_matches(team_id, opts \\ []), to: @client_module

  @impl true
  defdelegate e_team_players(team_id), to: @client_module

  ## Players

  @impl true
  defdelegate e_players(opts \\ []), to: @client_module

  @impl true
  defdelegate e_player(player_id), to: @client_module

  @impl true
  defdelegate e_player_stats(player_id), to: @client_module

  ## Stand alone

  @impl true
  defdelegate e_icc_ranks, to: @client_module
end
