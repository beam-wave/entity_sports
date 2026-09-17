defmodule EntitySports.Model.Responses.MatchInfo do
  @moduledoc """
  Exchange Match Info API response
  """
  use EntitySports.Schema
  alias EntitySports.Model.Responses

  embedded_schema do
    field(:raw_response, :map)
    field(:match_id, :integer)
    embeds_one(:match_info, Model.Match)
    embeds_one(:match_playing11, Responses.MatchSquads)
    field(:match_notes, Raw)
    embeds_one(:man_of_the_match, Model.NamedPlayer)
    field(:man_of_the_series, Raw)
    embeds_one(:scorecard, Model.Scorecard)
    embeds_one(:live, Model.MatchLive)
    embeds_one(:live_odds, Model.LiveOdd)
    embeds_one(:teamwinpercentage, Model.WinPercentage)
    embeds_many(:session_odds, Model.SessionOdd)
    embeds_many(:featured_session, Model.SessionOdd)
    embeds_many(:players, Model.Player)
  end

  def prepare(params) do
    params
    |> Helper.rename_key("match-playing11", "match_playing11")
    |> wrap_featured_session()
  end

  # a single featured session arrives as an object, several as a list
  defp wrap_featured_session(%{"featured_session" => %{"question_id" => _} = one} = params),
    do: Map.put(params, "featured_session", [one])

  defp wrap_featured_session(params), do: params
end
