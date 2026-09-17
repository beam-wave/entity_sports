defmodule EntitySports.Model.Responses.BallEvent do
  @moduledoc """
  Match Ball Event API response (exchange)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:match_id, :integer)
    # see Cricket Reference > Ball events
    field(:ball_event, :string)
  end
end
