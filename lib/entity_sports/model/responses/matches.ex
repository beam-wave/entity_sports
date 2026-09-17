defmodule EntitySports.Model.Responses.Match do
  @moduledoc """
  Matches List / Match Info / Competition Matches / Team Matches API response item
  """
  use EntitySports.Schema
  require EntitySports.Model.MatchFields

  embedded_schema do
    field(:raw_response, :map)
    EntitySports.Model.MatchFields.fields()
  end
end
