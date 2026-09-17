defmodule EntitySports.Model.IccRank do
  @moduledoc """
  ICC ranking row
  """
  use EntitySports.Schema

  embedded_schema do
    field(:rank, :integer)
    field(:pid, :integer)
    field(:tid, :integer)
    field(:player, :string)
    field(:team, :string)
    field(:rating, :integer)
    field(:points, :integer)
    # teams only
    field(:matches, :integer)
    field(:logo_url, :string)
    # players only
    field(:team_id, :integer)
    field(:careerbestrating, :string)
  end
end
