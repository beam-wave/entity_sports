defmodule EntitySports.Model.Team do
  @moduledoc """
  Match team (teama/teamb) model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_id, :integer)
    field(:name, :string)
    field(:short_name, :string)
    field(:logo_url, :string)
    field(:thumb_url, :string)
    field(:scores_full, :string)
    field(:scores, :string)
    field(:overs, :string)
  end
end
