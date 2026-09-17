defmodule EntitySports.Model.Responses.Players do
  @moduledoc """
  Player Search API response (paginated list of `Model.Player`)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:raw_response, :map)
    embeds_many(:items, Model.Player)
  end

  def render_many(response), do: Helper.render_page(response, &Model.Player.render/1)
end
