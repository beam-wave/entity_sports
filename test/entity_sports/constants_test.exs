defmodule EntitySports.ConstantsTest do
  use ExUnit.Case, async: true

  alias EntitySports.Constants

  test "status codes" do
    assert Constants.status(:live) == 3
    assert Constants.status("completed") == 2
    assert Constants.status(4) == 4
    assert Constants.status_name(1) == :scheduled
  end

  test "format codes" do
    assert Constants.format(:t20) == 6
    assert Constants.format_name(2) == :test
  end

  test "competition status" do
    assert Constants.competition_status(:fixture) == "fixture"
    assert Constants.competition_status(nil) == nil
    assert_raise ArgumentError, fn -> Constants.competition_status(:nope) end
  end

  test "unknown names raise" do
    assert_raise ArgumentError, fn -> Constants.game_state(:nope) end
  end
end
