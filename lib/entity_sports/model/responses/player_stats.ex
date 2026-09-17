defmodule EntitySports.Model.Responses.PlayerStats do
  @moduledoc """
  Player Statistic API response
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_one(:player, Model.Player)
    embeds_one(:batting, Model.BattingStats)
    embeds_one(:bowling, Model.BowlingStats)
  end
end
