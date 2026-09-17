defmodule EntitySports.Model.Responses.MatchWagons do
  @moduledoc """
  Match Wagon Wheel API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    # column names for each row in `innings[].wagons`
    field(:wagon_fields, {:array, :string})
    field(:zones, {:array, :string})
    # Enterprise plan only
    field(:ball_length, {:array, :string})
    field(:ball_side, {:array, :string})
    field(:ball_wide, {:array, :string})
    embeds_many(:innings, Model.WagonInning)
    embeds_many(:teams, Model.TeamSummary)
    embeds_many(:players, Model.PlayerSummary)
  end
end
