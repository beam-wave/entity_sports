defmodule EntitySports.Model.BowlingStats do
  @moduledoc """
  Player bowling stats grouped by format
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:test, Model.Bowling)
    embeds_one(:odi, Model.Bowling)
    embeds_one(:t20i, Model.Bowling)
    embeds_one(:t20, Model.Bowling)
    embeds_one(:lista, Model.Bowling)
    embeds_one(:firstclass, Model.Bowling)
    embeds_one(:t10, Model.Bowling)
    embeds_one(:t100, Model.Bowling)
    embeds_one(:youthodi, Model.Bowling)
    embeds_one(:youtht20, Model.Bowling)
    embeds_one(:womenodi, Model.Bowling)
    embeds_one(:woment20, Model.Bowling)
    embeds_one(:womentest, Model.Bowling)
    embeds_one(:womentt100, Model.Bowling)
  end
end
