defmodule EntitySports.Model.Odd do
  @moduledoc """
  Back/lay odd model (match odds, bookmaker, tied match)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:back, :string)
    field(:lay, :string)
    field(:back_volume, :string)
    field(:lay_volume, :string)
  end
end
