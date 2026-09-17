defmodule EntitySports.Model.Standing do
  @moduledoc """
  Standing table row
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_id, :integer)
    field(:played, :integer)
    field(:win, :integer)
    field(:loss, :integer)
    field(:draw, :integer)
    field(:nr, :integer)
    field(:overfor, Number)
    field(:runfor, :integer)
    field(:overagainst, Number)
    field(:runagainst, :integer)
    field(:netrr, Number)
    field(:points, :integer)
    field(:lastfivematch, :string)
    field(:lastfivematchresult, :string)
    field(:quality, :string)
    embeds_one(:team, Model.TeamDetail)
  end
end
