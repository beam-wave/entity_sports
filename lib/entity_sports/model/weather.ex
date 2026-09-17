defmodule EntitySports.Model.Weather do
  @moduledoc """
  Match weather model. See Cricket Reference > Weather Type
  """
  use EntitySports.Schema

  embedded_schema do
    field(:weather, :string)
    field(:weather_desc, :string)
    field(:temp, Number)
    field(:humidity, :integer)
    field(:visibility, :integer)
    field(:wind_speed, Number)
    field(:clouds, :integer)
  end
end
