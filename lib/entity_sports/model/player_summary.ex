defmodule EntitySports.Model.PlayerSummary do
  @moduledoc """
  Compact player model (statistics / wagons)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:player_id, :integer)
    field(:name, :string)
    field(:short_name, :string)
    field(:country_iso, :string)
    field(:logo_url, :string)
  end
end
