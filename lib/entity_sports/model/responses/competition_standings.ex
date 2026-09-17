defmodule EntitySports.Model.Responses.CompetitionStandings do
  @moduledoc """
  Competition Standings API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    # completed (single table for the whole season) or per_round (group wise)
    field(:standing_type, :string)
    embeds_many(:standings, Model.RoundStanding)
  end

  # `completed` standings are a flat list of rows; wrap them so the shape
  # matches the `per_round` variant.
  def prepare(%{"standings" => [%{"team_id" => _} | _] = rows} = params),
    do: Map.put(params, "standings", [%{"standings" => rows}])

  def prepare(params), do: params
end
