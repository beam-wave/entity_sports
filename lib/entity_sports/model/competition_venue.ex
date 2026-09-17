defmodule EntitySports.Model.CompetitionVenue do
  @moduledoc """
  Competition venue list entry
  """
  use EntitySports.Schema

  embedded_schema do
    field(:venue_id, :integer)
    field(:name, :string)
    field(:city, :string)
    field(:country, :string)
    field(:capacity, :string)
  end
end
