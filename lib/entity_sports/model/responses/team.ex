defmodule EntitySports.Model.Responses.Team do
  @moduledoc """
  Team API response / Team List API response item
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:tid, :integer)
    field(:title, :string)
    field(:abbr, :string)
    field(:alt_name, :string)
    # country (international team) or club
    field(:type, :string)
    field(:thumb_url, :string)
    field(:logo_url, :string)
    field(:country, :string)
    field(:sex, :string)
    field(:matches_url, :string)
  end
end
