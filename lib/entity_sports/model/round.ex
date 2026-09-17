defmodule EntitySports.Model.Round do
  @moduledoc """
  Competition round model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:rid, :integer)
    field(:name, :string)
    field(:order, :integer)
    field(:type, :string)
    field(:match_format, :string)
    field(:datestart, :string)
    field(:dateend, :string)
    field(:matches_url, :string)
    field(:teams_url, :string)
    embeds_one(:man_of_the_series, Model.NamedPlayer)
  end
end
