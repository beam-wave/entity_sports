defmodule EntitySports.Model.Responses.SettleMatchOdds do
  @moduledoc """
  Match Settle Odds API response item (exchange)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    field(:question_id, :integer)
    field(:team_batting, :string)
    field(:title, :string)
    field(:back_condition, :string)
    field(:back, :string)
    field(:lay_condition, :string)
    field(:lay, :string)
    field(:status, :string)
    # question outcome
    field(:settle, :string)
    field(:settle_type, :string)
    field(:settle_time, :string)
    field(:verified, :string)
    field(:verified_time, :string)
    # 1 - Unknown(default), 2 - Cancel, 3 - Rollback
    field(:qestatus, :integer)
  end
end
