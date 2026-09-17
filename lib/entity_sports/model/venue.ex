defmodule EntitySports.Model.Venue do
  @moduledoc """
  Match venue model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:venue_id, :integer)
    field(:name, :string)
    field(:location, :string)
    field(:country, :string)
    field(:timezone, :string)
  end
end
