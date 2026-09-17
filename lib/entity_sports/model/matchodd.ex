defmodule EntitySports.Model.Matchodd do
  @moduledoc """
  Match odds model
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:teama, Model.Odd)
    embeds_one(:teamb, Model.Odd)
  end
end
