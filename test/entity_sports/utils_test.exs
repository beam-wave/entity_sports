defmodule EntitySports.UtilsTest do
  use ExUnit.Case, async: true

  alias EntitySports.Utils

  describe "build_url/3" do
    test "drops nil params and encodes the rest" do
      assert Utils.build_url("https://x", "/matches", token: "t", status: 2, format: nil) ==
               "https://x/matches?token=t&status=2"
    end

    test "joins list params with commas" do
      assert Utils.build_url("https://x", "/odds", match_id: [1, 2]) ==
               "https://x/odds?match_id=1%2C2"
    end

    test "no query when every param is nil" do
      assert Utils.build_url("https://x", "/seasons", a: nil) == "https://x/seasons"
    end
  end

  describe "match_filters/1" do
    test "maps atoms to codes and builds the date range" do
      params =
        Utils.match_filters(
          status: :live,
          format: :t20,
          start_date: "2024-01-01",
          end_date: "2024-01-31",
          page: 2,
          per_page: 10
        )

      assert params[:status] == 3
      assert params[:format] == 6
      assert params[:date] == "2024-01-01_2024-01-31"
      assert params[:paged] == 2
      assert params[:per_page] == 10
    end

    test "explicit date wins over start/end" do
      assert Utils.match_filters(date: "2024-01-01_2024-01-02")[:date] == "2024-01-01_2024-01-02"
    end

    test "integer status passes through" do
      assert Utils.match_filters(status: 2)[:status] == 2
    end
  end

  describe "deserialize_response/2" do
    test "ok status renders the response node" do
      body = ~s({"status":"ok","response":{"a":1}})
      resp = {:ok, %HTTPoison.Response{status_code: 200, body: body}}
      assert {:ok, %{"a" => 1}} = Utils.deserialize_response(resp, &{:ok, &1})
    end

    test "api error status returns error tuple" do
      body = ~s({"status":"unauthorized","response":"invalid token"})
      resp = {:ok, %HTTPoison.Response{status_code: 200, body: body}}
      assert {:error, 200, "invalid token"} = Utils.deserialize_response(resp, &{:ok, &1})

      body = ~s({"status":202,"message":"match not found"})
      resp = {:ok, %HTTPoison.Response{status_code: 200, body: body}}
      assert {:error, 200, "match not found"} = Utils.deserialize_response(resp, &{:ok, &1})
    end

    test "http error returns status and body" do
      resp = {:ok, %HTTPoison.Response{status_code: 401, body: "nope"}}
      assert {:error, 401, "nope"} = Utils.deserialize_response(resp, &{:ok, &1})
    end

    test "transport error returns 0" do
      resp = {:error, %HTTPoison.Error{reason: :timeout}}
      assert {:error, 0, _} = Utils.deserialize_response(resp, &{:ok, &1})
    end
  end
end
