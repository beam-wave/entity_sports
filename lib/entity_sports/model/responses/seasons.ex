defmodule EntitySports.Model.Responses.Seasons do
  @moduledoc """
  Seasons API response item
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:sid, :string)
    field(:name, :string)
    field(:competitions_url, :string)
  end
end
