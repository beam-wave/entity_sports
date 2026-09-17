defmodule EntitySports.Model.TeamDetail do
  @moduledoc """
  Team model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:tid, :integer)
    field(:title, :string)
    field(:abbr, :string)
    field(:alt_name, :string)
    # country (international team) or club
    field(:type, :string)
    field(:thumb_url, :string)
    field(:logo_url, :string)
    # Country ISO Code
    field(:country, :string)
    field(:sex, :string)
    field(:matches_url, :string)
  end
end
