defmodule EntitySports.Model.TeamSummary do
  @moduledoc """
  Compact team model (statistics / wagons)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:team_id, :integer)
    field(:name, :string)
    field(:short_name, :string)
    field(:country_iso, :string)
    field(:type, :string)
    field(:logo_url, :string)
  end
end
