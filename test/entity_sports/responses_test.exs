defmodule EntitySports.ResponsesTest do
  use ExUnit.Case, async: true

  alias EntitySports.Fixtures
  alias EntitySports.Model
  alias EntitySports.Model.Responses

  describe "cricket v2 responses" do
    test "seasons" do
      assert {:ok, [%Responses.Seasons{sid: "2015"} | _], _pages, _items} =
               Responses.Seasons.render_many(Fixtures.response(:v2, :seasons))
    end

    test "season competitions" do
      assert {:ok, [%Responses.Competitions{cid: cid, rounds: [%Model.Round{} | _]} | _], _, _} =
               Responses.Competitions.render_many(Fixtures.response(:v2, :season_competitions))

      assert is_integer(cid)
    end

    test "competitions" do
      assert {:ok, [%Responses.Competitions{cid: cid} | _], pages, items} =
               Responses.Competitions.render_many(Fixtures.response(:v2, :competitions))

      assert is_integer(cid) and is_integer(pages) and is_integer(items)
    end

    test "competition overview" do
      assert {:ok,
              %Responses.CompetitionOverview{
                cid: cid,
                rounds: [%Model.Round{rid: rid} | _],
                venue_list: [%Model.CompetitionVenue{} | _]
              }} = Responses.CompetitionOverview.render(Fixtures.response(:v2, :competition))

      assert is_integer(cid) and is_integer(rid)
    end

    test "competition matches" do
      assert {:ok, [%Responses.Match{match_id: id, teama: %Model.Team{}} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:v2, :competition_matches))

      assert is_integer(id)
    end

    test "competition teams" do
      assert {:ok, %Responses.CompetitionTeams{teams: [%Model.TeamDetail{tid: tid} | _]}} =
               Responses.CompetitionTeams.render(Fixtures.response(:v2, :competition_teams))

      assert is_integer(tid)
    end

    test "competition squads" do
      assert {:ok,
              %Responses.CompetitionSquads{
                squad_type: "per_team",
                squads: [
                  %Model.Squad{team: %Model.TeamDetail{}, players: [%Model.Player{} | _]} | _
                ]
              }} = Responses.CompetitionSquads.render(Fixtures.response(:v2, :competition_squads))
    end

    test "competition standings" do
      assert {:ok,
              %Responses.CompetitionStandings{
                standings: [
                  %Model.RoundStanding{
                    round: %Model.Round{},
                    standings: [%Model.Standing{team: %Model.TeamDetail{}} | _]
                  }
                  | _
                ]
              }} =
               Responses.CompetitionStandings.render(
                 Fixtures.response(:v2, :competition_standings)
               )
    end

    test "competition standings (completed, flat list)" do
      params = %{
        "standing_type" => "completed",
        "standings" => [%{"team_id" => "1", "played" => "2", "team" => %{"tid" => 1}}]
      }

      assert {:ok,
              %Responses.CompetitionStandings{
                standings: [
                  %Model.RoundStanding{round: nil, standings: [%Model.Standing{team_id: 1}]}
                ]
              }} = Responses.CompetitionStandings.render(params)
    end

    test "competition stat types" do
      assert {:ok,
              %Responses.CompetitionStats{
                stats: [%Model.CompetitionStat{player: %Model.Player{}} | _],
                stat_types: [%Model.StatType{types: %{}} | _],
                teams: [%Model.TeamSummary{} | _]
              }} =
               Responses.CompetitionStats.render(Fixtures.response(:v2, :competition_stat_types))
    end

    test "competition stats" do
      assert {:ok, %Responses.CompetitionStats{stat_types: [_ | _]}} =
               Responses.CompetitionStats.render(Fixtures.response(:v2, :competition_stats))
    end

    test "matches" do
      assert {:ok, [%Responses.Match{match_id: id, competition: %Model.Competition{}} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:v2, :matches))

      assert is_integer(id)
    end

    test "match info" do
      assert {:ok, %Responses.Match{match_id: id, toss: %Model.Toss{}, venue: %Model.Venue{}}} =
               Responses.Match.render(Fixtures.response(:v2, :match))

      assert is_integer(id)
    end

    test "match scorecard" do
      assert {:ok,
              %Responses.MatchScorecard{
                match_id: id,
                innings: [
                  %Model.MatchInning{
                    batsmen: [%Model.Batsman{} | _],
                    bowlers: [%Model.Bowler{} | _],
                    fows: [%Model.Fow{} | _],
                    extra_runs: %Model.ExtraRuns{}
                  }
                  | _
                ],
                players: [%Model.Player{} | _]
              }} = Responses.MatchScorecard.render(Fixtures.response(:v2, :match_scorecard))

      assert is_integer(id)
    end

    test "match innings commentary" do
      assert {:ok,
              %Responses.MatchInningsCommentary{
                match: %Model.MatchStatus{},
                inning: %Model.MatchInning{},
                commentaries: [%Model.Commentary{} | _]
              }} =
               Responses.MatchInningsCommentary.render(
                 Fixtures.response(:v2, :match_innings_commentary)
               )
    end

    test "match live" do
      assert {:ok,
              %Responses.MatchLive{
                mid: mid,
                live_score: %Model.MatchLiveScore{},
                batsmen: [%Model.MatchLiveBatsmen{} | _],
                bowlers: [%Model.MatchLiveBowler{} | _],
                commentaries: [%Model.Commentary{bats: [%Model.CommentaryBats{} | _]} | _],
                live_inning: %Model.MatchInning{},
                teams: [%Model.TeamDetail{} | _],
                players: [%Model.Player{} | _]
              }} = Responses.MatchLive.render(Fixtures.response(:v2, :match_live))

      assert is_integer(mid)
    end

    test "match squads (playing 11)" do
      assert {:ok,
              %Responses.MatchSquads{
                teama: %Model.TeamSquad{squads: [%Model.SquadPlayer{} | _]},
                teamb: %Model.TeamSquad{},
                players: [%Model.Player{} | _]
              }} = Responses.MatchSquads.render(Fixtures.response(:v2, :match_squads))
    end

    test "match statistics" do
      assert {:ok,
              %Responses.MatchStatistics{
                innings: [%Model.StatInning{statistics: %{"manhattan" => _}} | _]
              }} = Responses.MatchStatistics.render(Fixtures.response(:v2, :match_statistics))
    end

    test "match wagons" do
      assert {:ok,
              %Responses.MatchWagons{
                wagon_fields: [_ | _],
                innings: [%Model.WagonInning{wagons: [_ | _]} | _]
              }} = Responses.MatchWagons.render(Fixtures.response(:v2, :match_wagons))
    end

    test "players" do
      assert {:ok, [%Model.Player{pid: pid} | _], _, _} =
               Responses.Players.render_many(Fixtures.response(:v2, :players))

      assert is_integer(pid)
    end

    test "player profile" do
      assert {:ok, %Responses.PlayerProfile{player: %Model.Player{pid: 119}}} =
               Responses.PlayerProfile.render(Fixtures.response(:v2, :player))
    end

    test "player stats" do
      assert {:ok,
              %Responses.PlayerStats{
                player: %Model.Player{},
                batting: %Model.BattingStats{test: %Model.Batting{}},
                bowling: %Model.BowlingStats{odi: %Model.Bowling{}}
              }} = Responses.PlayerStats.render(Fixtures.response(:v2, :player_stats))
    end

    test "team" do
      assert {:ok, %Responses.Team{tid: 25}} =
               Responses.Team.render(Fixtures.response(:v2, :team))
    end

    test "team matches" do
      assert {:ok, [%Responses.Match{} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:v2, :team_matches))
    end

    test "team players" do
      assert {:ok,
              %Responses.TeamPlayers{
                team: %Model.TeamDetail{},
                players: [%Model.Player{} | _],
                players_by_format: %Model.PlayersByFormat{t20: [%Model.Player{} | _]}
              }} = Responses.TeamPlayers.render(Fixtures.response(:v2, :team_players))
    end

    test "icc ranks" do
      assert {:ok,
              %Responses.IccRanks{
                ranks: %Model.IccRankGroup{
                  batsmen: %Model.IccRankCategory{odis: [%Model.IccRank{} | _]}
                }
              }} = Responses.IccRanks.render(Fixtures.response(:v2, :icc_ranks))
    end
  end

  describe "cricket exchange responses" do
    test "competitions" do
      assert {:ok, [%Responses.Competitions{} | _], _, _} =
               Responses.Competitions.render_many(Fixtures.response(:exchange, :competitions))
    end

    test "competition info" do
      assert {:ok,
              %Responses.CompetitionOverview{
                teams: [%Model.TeamDetail{} | _],
                standing: %Responses.CompetitionStandings{}
              }} =
               Responses.CompetitionOverview.render(Fixtures.response(:exchange, :competition))
    end

    test "competition matches" do
      assert {:ok, [%Responses.Match{pitch: %Model.Pitch{}} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:exchange, :competition_matches))
    end

    test "competition squads" do
      assert {:ok, %Responses.CompetitionSquads{squads: [%Model.Squad{} | _]}} =
               Responses.CompetitionSquads.render(
                 Fixtures.response(:exchange, :competition_squads)
               )
    end

    test "competition stats" do
      assert {:ok, %Responses.CompetitionStats{}} =
               Responses.CompetitionStats.render(Fixtures.response(:exchange, :competition_stats))

      assert {:ok, %Responses.CompetitionStats{stats: [%Model.CompetitionStat{} | _]}} =
               Responses.CompetitionStats.render(
                 Fixtures.response(:exchange, :competition_stat_types)
               )
    end

    test "matches" do
      assert {:ok, [%Responses.Match{session_odds_available: flag} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:exchange, :matches))

      assert is_boolean(flag)
    end

    test "match info" do
      assert {:ok,
              %Responses.MatchInfo{
                match_id: id,
                match_info: %Model.Match{weather: %Model.Weather{}},
                match_playing11: %Responses.MatchSquads{teama: %Model.TeamSquad{}},
                scorecard: %Model.Scorecard{innings: [%Model.MatchInning{} | _]},
                live: %Model.MatchLive{live_inning: %Model.MatchInning{}},
                players: [%Model.Player{} | _]
              }} = Responses.MatchInfo.render(Fixtures.response(:exchange, :match))

      assert is_integer(id)
    end

    test "match odds" do
      assert {:ok,
              %Responses.MatchOdds{
                match_info: %Model.Match{},
                live_odds: %Model.LiveOdd{matchodds: %Model.Matchodd{teama: %Model.Odd{}}}
              }} = Responses.MatchOdds.render(Fixtures.response(:exchange, :match_odds))
    end

    test "multi match odds" do
      assert {:ok, %Responses.MultiMatchOdds{odds: odds}} =
               Responses.MultiMatchOdds.render(Fixtures.response(:exchange, :multi_match_odds))

      assert [%Model.MatchOddsEntry{match_id: 77_363, live_odds: %Model.LiveOdd{}}, _] =
               Enum.sort_by(odds, & &1.match_id)
    end

    test "settle match odds" do
      assert {:ok, [%Responses.SettleMatchOdds{question_id: qid} | _], _, _} =
               Responses.SettleMatchOdds.render_many(
                 Fixtures.response(:exchange, :settle_match_odds)
               )

      assert is_integer(qid)
    end

    test "match wagons" do
      assert {:ok, %Responses.MatchWagons{}} =
               Responses.MatchWagons.render(Fixtures.response(:exchange, :match_wagons))
    end

    test "match statistics" do
      assert {:ok,
              %Responses.MatchStatistics{
                venue_stats: %{},
                teams: [%Model.TeamSummary{} | _],
                players: [%Model.PlayerSummary{} | _]
              }} =
               Responses.MatchStatistics.render(Fixtures.response(:exchange, :match_statistics))
    end

    test "match innings commentary" do
      assert {:ok, %Responses.MatchInningsCommentary{commentaries: [_ | _]}} =
               Responses.MatchInningsCommentary.render(
                 Fixtures.response(:exchange, :match_innings_commentary)
               )
    end

    test "ball event" do
      assert {:ok, %Responses.BallEvent{match_id: 64_441}} =
               Responses.BallEvent.render(Fixtures.response(:exchange, :match_ball_event))
    end

    test "round matches" do
      assert {:ok, %Responses.RoundMatches{matches: [%Model.Match{} | _]}} =
               Responses.RoundMatches.render(Fixtures.response(:exchange, :round_matches))
    end

    test "round teams" do
      assert {:ok, %Responses.CompetitionTeams{teams: [%Model.TeamDetail{} | _]}} =
               Responses.CompetitionTeams.render(Fixtures.response(:exchange, :round_teams))
    end

    test "teams" do
      assert {:ok, [%Responses.Team{tid: tid} | _], _, _} =
               Responses.Team.render_many(Fixtures.response(:exchange, :teams))

      assert is_integer(tid)
    end

    test "team" do
      assert {:ok, %Responses.Team{}} = Responses.Team.render(Fixtures.response(:exchange, :team))
    end

    test "team matches" do
      assert {:ok, [%Responses.Match{} | _], _, _} =
               Responses.Match.render_many(Fixtures.response(:exchange, :team_matches))
    end

    test "team players" do
      assert {:ok, %Responses.TeamPlayers{team: %Model.TeamDetail{}}} =
               Responses.TeamPlayers.render(Fixtures.response(:exchange, :team_players))
    end

    test "players" do
      assert {:ok, [%Model.Player{} | _], _, _} =
               Responses.Players.render_many(Fixtures.response(:exchange, :players))
    end

    test "player / player stats" do
      assert {:ok, %Responses.PlayerProfile{player: %Model.Player{}}} =
               Responses.PlayerProfile.render(Fixtures.response(:exchange, :player))

      assert {:ok, %Responses.PlayerStats{batting: %Model.BattingStats{}}} =
               Responses.PlayerStats.render(Fixtures.response(:exchange, :player_stats))
    end

    test "icc ranks" do
      assert {:ok, %Responses.IccRanks{ranks: %Model.IccRankGroup{}}} =
               Responses.IccRanks.render(Fixtures.response(:exchange, :icc_ranks))
    end
  end
end
