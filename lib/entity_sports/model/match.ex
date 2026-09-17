defmodule EntitySports.Model.Match do
  @moduledoc """
  Match model
  """
  use EntitySports.Schema
  require EntitySports.Model.MatchFields

  embedded_schema do
    EntitySports.Model.MatchFields.fields()
  end
end
