defmodule EntitySports.Model.SessionOdd do
  @moduledoc """
  Session odds model
  """
  use EntitySports.Schema

  embedded_schema do
    field(:question_id, :integer)
    field(:team_batting, :string)
    field(:title, :string)
    # Run, Wicket, Four, Six, Balls, ... or "" for match-level markets
    field(:category, :string)
    field(:back_condition, :string)
    field(:back, :string)
    field(:lay_condition, :string)
    field(:lay, :string)
    field(:status, :string)
    field(:settle, :string)
    field(:settle_type, :string)
    field(:settle_time, :string)
    field(:verified, :string)
    field(:verified_time, :string)
    # Question settlement: 1 - Unknown(default), 2 - Cancel, 3 - Rollback
    field(:qestatus, :integer)
  end
end
