defmodule EntitySports.Model.RoundStanding do
  @moduledoc """
  Standing table for a round / group
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:round, Model.Round)
    embeds_many(:standings, Model.Standing)
  end
end
