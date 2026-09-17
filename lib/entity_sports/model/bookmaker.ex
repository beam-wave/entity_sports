defmodule EntitySports.Model.Bookmaker do
  @moduledoc """
  Bookmaker odds model
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:teama, Model.Odd)
    embeds_one(:teamb, Model.Odd)
  end
end
