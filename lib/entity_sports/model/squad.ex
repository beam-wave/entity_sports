defmodule EntitySports.Model.Squad do
  @moduledoc """
  Competition squad model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_id, :integer)
    field(:title, :string)
    field(:gmdate, :string)
    field(:format, :string)
    field(:format_str, :string)
    embeds_one(:team, Model.TeamDetail)
    embeds_many(:players, Model.Player)
    embeds_many(:last_match_played, Model.DidNotBat)
  end
end
