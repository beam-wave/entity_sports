defmodule EntitySports.Model.Fielder do
  @moduledoc """
  Scorecard fielder model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:fielder_id, :integer)
    field(:fielder_name, :string)
    field(:catches, :integer)
    field(:runout_thrower, :integer)
    field(:runout_catcher, :integer)
    field(:runout_direct_hit, :integer)
    field(:stumping, :integer)
    field(:is_substitute, :string)
  end
end
