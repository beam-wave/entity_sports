defmodule EntitySports.Type.Raw do
  @moduledoc """
  Pass-through Ecto type.

  EntitySports returns several fields with an unstable JSON type (e.g. an
  integer in one endpoint and a string in another, or an object that becomes
  an empty array when absent). This type keeps the decoded JSON value as is.
  """
  use Ecto.Type

  @impl true
  def type, do: :map

  @impl true
  def cast(value), do: {:ok, value}

  @impl true
  def load(value), do: {:ok, value}

  @impl true
  def dump(value), do: {:ok, value}
end
