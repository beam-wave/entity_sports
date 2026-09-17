defmodule EntitySports.Model.Tiedmatch do
  @moduledoc """
  Tied match odds model
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:teama, Model.Odd)
    embeds_one(:teamb, Model.Odd)
  end
end
