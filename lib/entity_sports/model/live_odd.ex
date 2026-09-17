defmodule EntitySports.Model.LiveOdd do
  @moduledoc """
  Live odds model
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_one(:matchodds, Model.Matchodd)
    embeds_one(:tiedmatch, Model.Tiedmatch)
    embeds_one(:bookmaker, Model.Bookmaker)
    embeds_one(:toss, Model.Matchodd)
  end

  # API key is "Toss"
  def prepare(params), do: Helper.rename_key(params, "Toss", "toss")
end
