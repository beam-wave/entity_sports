defmodule EntitySports.Model.BattingStats do
  @moduledoc """
  Player batting stats grouped by format
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:test, Model.Batting)
    embeds_one(:odi, Model.Batting)
    embeds_one(:t20i, Model.Batting)
    embeds_one(:t20, Model.Batting)
    embeds_one(:lista, Model.Batting)
    embeds_one(:firstclass, Model.Batting)
    embeds_one(:t10, Model.Batting)
    embeds_one(:t100, Model.Batting)
    embeds_one(:youthodi, Model.Batting)
    embeds_one(:youtht20, Model.Batting)
    embeds_one(:womenodi, Model.Batting)
    embeds_one(:woment20, Model.Batting)
    embeds_one(:womentest, Model.Batting)
    embeds_one(:womentt100, Model.Batting)
  end
end
