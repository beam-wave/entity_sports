defmodule EntitySports.Model.Competition do
  @moduledoc """
  Competition model (as embedded in match objects and lists)
  """
  use EntitySports.Schema

  embedded_schema do
    field(:cid, :integer)
    field(:title, :string)
    field(:abbr, :string)
    # tour, tournament, series
    field(:type, :string)
    # international, domestic, youth, women
    field(:category, :string)
    # mixed, odi, test, t20i, firstclass, lista, t20, youthodi, youtht20, womenodi, woment20
    field(:match_format, :string)
    field(:game_format, :string)
    # live, fixture, result
    field(:status, :string)
    field(:season, :string)
    field(:datestart, :date)
    field(:dateend, :date)
    field(:total_matches, :integer)
    field(:total_rounds, :integer)
    field(:total_teams, :integer)
    # Country ISO Code
    field(:country, :string)
    field(:matches_url, :string)
    field(:teams_url, :string)
    field(:standings_url, :string)
    embeds_many(:rounds, Model.Round)
  end
end
