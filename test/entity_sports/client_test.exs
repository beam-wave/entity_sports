defmodule EntitySports.ClientTest do
  @moduledoc """
  Every public function of both clients resolves to the stub in test env and
  returns a rendered struct.
  """
  use ExUnit.Case, async: true

  alias EntitySports.Client
  alias EntitySports.Exchange.Client, as: Exchange
  alias EntitySports.Model
  alias EntitySports.Model.Responses

  describe "EntitySports.Client" do
    test "seasons" do
      assert {:ok, [%Responses.Seasons{} | _], _, _} = Client.seasons()
    end

    test "season_competitions" do
      assert {:ok, [%Responses.Competitions{} | _], _, _} = Client.season_competitions(2021)
    end

    test "competitions" do
      assert {:ok, [%Responses.Competitions{} | _], _, _} = Client.competitions(:live, 1, 10)
    end

    test "competition" do
      assert {:ok, %Responses.CompetitionOverview{}} = Client.competition(1)
    end

    test "competition_matches" do
      assert {:ok, [%Responses.Match{} | _], _, _} = Client.competition_matches(1, page: 1)
    end

    test "competition_teams" do
      assert {:ok, %Responses.CompetitionTeams{}} = Client.competition_teams(1)
    end

    test "competition_squads" do
      assert {:ok, %Responses.CompetitionSquads{}} = Client.competition_squads(1)
    end

    test "competition_standings" do
      assert {:ok, %Responses.CompetitionStandings{}} = Client.competition_standings(1)
    end

    test "competition_stat_types / competition_stats" do
      assert {:ok, %Responses.CompetitionStats{}} = Client.competition_stat_types(1)

      assert {:ok, %Responses.CompetitionStats{}} =
               Client.competition_stats(1, "batting_most_runs")
    end

    test "matches" do
      assert {:ok, [%Responses.Match{} | _], _, _} =
               Client.matches(:completed, "2024-01-01", "2024-01-02", 1, 10)

      assert {:ok, [%Responses.Match{} | _], _, _} = Client.matches(status: :live)
    end

    test "match" do
      assert {:ok, %Responses.Match{}} = Client.match(1)
      assert {:ok, %Responses.Match{}} = Client.match(1, day: 1)
    end

    test "match_scorecard" do
      assert {:ok, %Responses.MatchScorecard{}} = Client.match_scorecard(1)
    end

    test "match_innings_commentary" do
      assert {:ok, %Responses.MatchInningsCommentary{}} = Client.match_innings_commentary(1, 1)
    end

    test "match_live" do
      assert {:ok, %Responses.MatchLive{}} = Client.match_live(1)
    end

    test "match_squads / match_statistics / match_wagons" do
      assert {:ok, %Responses.MatchSquads{}} = Client.match_squads(1)
      assert {:ok, %Responses.MatchStatistics{}} = Client.match_statistics(1)
      assert {:ok, %Responses.MatchWagons{}} = Client.match_wagons(1)
    end

    test "players / player / player_stats" do
      assert {:ok, [%Model.Player{} | _], _, _} = Client.players(country: "in")
      assert {:ok, %Responses.PlayerProfile{}} = Client.player(1)
      assert {:ok, %Responses.PlayerStats{}} = Client.player_stats(1)
      assert {:ok, %Responses.PlayerStats{}} = Client.player_statstic(1)
    end

    test "team / team_matches / team_players" do
      assert {:ok, %Responses.Team{}} = Client.team(1)
      assert {:ok, [%Responses.Match{} | _], _, _} = Client.team_matches(1, status: :completed)
      assert {:ok, %Responses.TeamPlayers{}} = Client.team_players(1)
    end

    test "icc_ranks" do
      assert {:ok, %Responses.IccRanks{}} = Client.icc_ranks()
    end
  end

  describe "EntitySports.Exchange.Client" do
    test "competitions" do
      assert {:ok, [%Responses.Competitions{} | _], _, _} = Exchange.e_competitions(status: :live)
      assert {:ok, %Responses.CompetitionOverview{}} = Exchange.e_competition(1)
      assert {:ok, [%Responses.Match{} | _], _, _} = Exchange.e_competition_matches(1)
      assert {:ok, %Responses.CompetitionSquads{}} = Exchange.e_competition_squads(1)
      assert {:ok, %Responses.CompetitionStats{}} = Exchange.e_competition_stat_types(1)

      assert {:ok, %Responses.CompetitionStats{}} =
               Exchange.e_competition_stats(1, "batting_most_runs")
    end

    test "matches" do
      assert {:ok, [%Responses.Match{} | _], _, _} =
               Exchange.e_matches(:live, "2024-01-01", "2024-01-02", 1, 10)

      assert {:ok, [%Responses.Match{} | _], _, _} = Exchange.e_matches(status: :live)
      assert {:ok, %Responses.MatchInfo{}} = Exchange.e_match(1)
      assert {:ok, %Responses.MatchOdds{}} = Exchange.e_match_odds(1)
      assert {:ok, %Responses.MultiMatchOdds{}} = Exchange.e_multi_match_odds([1, 2])
      assert {:ok, [%Responses.SettleMatchOdds{} | _], _, _} = Exchange.e_settle_match_odds(1)

      assert {:ok, [%Responses.SettleMatchOdds{} | _], _, _} =
               Exchange.e_settle_match_odds(1, status: 2)

      assert {:ok, %Responses.MatchInningsCommentary{}} =
               Exchange.e_match_innings_commentary(1, 1)

      assert {:ok, %Responses.MatchStatistics{}} = Exchange.e_match_statistics(1)
      assert {:ok, %Responses.MatchWagons{}} = Exchange.e_match_wagons(1)
      assert {:ok, %Responses.BallEvent{}} = Exchange.e_match_ball_event(1)
    end

    test "rounds" do
      assert {:ok, %Responses.RoundMatches{}} = Exchange.e_round_matches(1)
      assert {:ok, %Responses.CompetitionTeams{}} = Exchange.e_round_teams(1)
    end

    test "teams" do
      assert {:ok, [%Responses.Team{} | _], _, _} = Exchange.e_teams()
      assert {:ok, %Responses.Team{}} = Exchange.e_team(1)
      assert {:ok, [%Responses.Match{} | _], _, _} = Exchange.e_team_matches(1)
      assert {:ok, %Responses.TeamPlayers{}} = Exchange.e_team_players(1)
    end

    test "players" do
      assert {:ok, [%Model.Player{} | _], _, _} = Exchange.e_players()
      assert {:ok, %Responses.PlayerProfile{}} = Exchange.e_player(1)
      assert {:ok, %Responses.PlayerStats{}} = Exchange.e_player_stats(1)
    end

    test "icc ranks" do
      assert {:ok, %Responses.IccRanks{}} = Exchange.e_icc_ranks()
    end
  end
end
