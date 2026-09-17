defmodule EntitySports.Model.Scorecard do
  @moduledoc """
  Exchange scorecard model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:is_followon, :integer)
    field(:day_remaining_over, :string)
    embeds_many(:innings, Model.MatchInning)
  end
end
