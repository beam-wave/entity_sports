defmodule EntitySports.Model.PlayersByFormat do
  @moduledoc """
  Team players grouped by format
  """
  use EntitySports.Schema

  embedded_schema do
    embeds_many(:test, Model.Player)
    embeds_many(:odi, Model.Player)
    embeds_many(:t20i, Model.Player)
    embeds_many(:t20, Model.Player)
    embeds_many(:lista, Model.Player)
    embeds_many(:firstclass, Model.Player)
    embeds_many(:t10, Model.Player)
    embeds_many(:t100, Model.Player)
    embeds_many(:youthodi, Model.Player)
    embeds_many(:youtht20, Model.Player)
    embeds_many(:womenodi, Model.Player)
    embeds_many(:woment20, Model.Player)
    embeds_many(:womentest, Model.Player)
    embeds_many(:womentt100, Model.Player)
  end
end
