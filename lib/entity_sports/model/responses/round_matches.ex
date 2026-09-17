defmodule EntitySports.Model.Responses.RoundMatches do
  @moduledoc """
  Rounds Matches API response (exchange)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:total_matches, :integer)
    embeds_many(:matches, Model.Match)
  end
end
