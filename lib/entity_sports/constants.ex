defmodule EntitySports.Constants do
  @moduledoc """
  Numeric codes used by the EntitySports Cricket API.
  See https://www.doc.entitysport.com (Cricket Reference).

  Every `*/1` function accepts the atom (or string) name and returns the code;
  integers are passed through untouched so callers may use either.
  `*_name/1` functions do the reverse lookup.
  """

  ## Match Status
  @match_status %{scheduled: 1, completed: 2, live: 3, abandoned: 4, canceled: 4, no_result: 4}
  @match_status_names %{1 => :scheduled, 2 => :completed, 3 => :live, 4 => :abandoned}

  def status(code) when is_integer(code), do: code
  def status(name), do: lookup!(@match_status, name)
  def status_name(code), do: Map.get(@match_status_names, code)

  ## Innings Status
  @inning_status %{scheduled: 1, completed: 2, live: 3, abandoned: 4}
  def inning_status(code) when is_integer(code), do: code
  def inning_status(name), do: lookup!(@inning_status, name)
  def inning_status_name(code), do: reverse(@inning_status, code)

  ## Innings Result
  @inning_result %{default: 0, all_out: 1, declared: 2, target_reached: 3, over_reached: 4}
  def inning_result(code) when is_integer(code), do: code
  def inning_result(name), do: lookup!(@inning_result, name)
  def inning_result_name(code), do: reverse(@inning_result, code)

  ## Match Format
  @format %{
    odi: 1,
    test: 2,
    t20i: 3,
    lista: 4,
    firstclass: 5,
    t20: 6,
    women_odi: 7,
    women_t20: 8,
    youth_odi: 9,
    youth_t20: 10,
    other: 11,
    other_lista: 12,
    other_firstclass: 13,
    other_t20: 14,
    youth_test: 15,
    women_test: 16,
    t10: 17,
    t100: 18,
    women_t100: 19,
    tb10: 20,
    women_t20i: 21
  }
  def format(code) when is_integer(code), do: code
  def format(name), do: lookup!(@format, name)
  def format_name(code), do: reverse(@format, code)

  ## Match Game State (live matches only)
  @game_state %{
    default: 0,
    starts_shortly: 1,
    toss: 2,
    play_ongoing: 3,
    delayed: 4,
    drinks_break: 5,
    innings_break: 6,
    stumps: 7,
    lunch_break: 8,
    tea_break: 9,
    match_start_delay: 10,
    rain_delay: 11,
    dinner: 12,
    strategic_timeout: 13,
    technical_issue: 14,
    bad_light: 15,
    match_interrupted: 16
  }
  def game_state(code) when is_integer(code), do: code
  def game_state(name), do: lookup!(@game_state, name)
  def game_state_name(code), do: reverse(@game_state, code)

  ## Match Result Type
  @result_type %{
    none: 0,
    team1_wins: 1,
    team2_wins: 2,
    drawn: 3,
    no_result: 4,
    tie: 5,
    cancelled: 6
  }
  def result_type(code) when is_integer(code), do: code
  def result_type(name), do: lookup!(@result_type, name)
  def result_type_name(code), do: reverse(@result_type, code)

  ## Toss Decision
  @toss_decision %{batting: 1, fielding: 2}
  def toss_decision(code) when is_integer(code), do: code
  def toss_decision(name), do: lookup!(@toss_decision, name)
  def toss_decision_name(code), do: reverse(@toss_decision, code)

  ## Match Domestic
  @domestic %{international: 0, domestic: 1}
  def domestic(code) when is_integer(code), do: code
  def domestic(name), do: lookup!(@domestic, name)
  def domestic_name(code), do: reverse(@domestic, code)

  ## Competition Status (string parameter)
  @competition_status ~w(fixture result live)
  def competition_status(nil), do: nil

  def competition_status(status) when is_atom(status),
    do: competition_status(Atom.to_string(status))

  def competition_status(status) when status in @competition_status, do: status

  def competition_status(status),
    do: raise(ArgumentError, "unknown competition status #{inspect(status)}")

  ## Session Odds Question Settlement Status
  @question_status %{unknown: 1, cancel: 2, rollback: 3}
  def question_status(code) when is_integer(code), do: code
  def question_status(name), do: lookup!(@question_status, name)
  def question_status_name(code), do: reverse(@question_status, code)

  defp lookup!(map, name) when is_binary(name), do: lookup!(map, String.to_existing_atom(name))

  defp lookup!(map, name) when is_atom(name) do
    case Map.fetch(map, name) do
      {:ok, code} -> code
      :error -> raise ArgumentError, "unknown code name #{inspect(name)}"
    end
  end

  defp reverse(map, code), do: Enum.find_value(map, fn {name, c} -> if c == code, do: name end)
end
