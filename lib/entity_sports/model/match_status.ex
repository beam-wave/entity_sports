defmodule EntitySports.Model.MatchStatus do
  @moduledoc """
  Match status model (innings commentary)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:status, :integer)
    field(:game_state, :integer)
  end
end
