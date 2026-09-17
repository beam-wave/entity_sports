defmodule EntitySports.Model.NamedPlayer do
  @moduledoc """
  Player reference (man of the match / series)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:pid, :integer)
    field(:name, :string)
    field(:thumb_url, :string)
  end
end
