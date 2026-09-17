defmodule EntitySports.Model.Responses.MatchInningsCommentary do
  @moduledoc """
  Match Innings Commentary API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:match, Model.MatchStatus)
    embeds_one(:inning, Model.MatchInning)
    embeds_many(:commentaries, Model.Commentary)
    embeds_many(:teams, Model.TeamDetail)
    embeds_many(:players, Model.Player)
  end
end
