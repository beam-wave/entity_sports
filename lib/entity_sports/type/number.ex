defmodule EntitySports.Type.Number do
  @moduledoc """
  Numeric Ecto type accepting integers, floats and numeric strings.

  EntitySports serialises many numeric values as strings in some endpoints
  and as numbers in others (`"strike_rate": "112.5"` vs `"strike_rate": 112.5`).
  Integers stay integers, everything else becomes a float. Blank strings
  cast to `nil`.
  """
  use Ecto.Type

  @impl true
  def type, do: :float

  @impl true
  def cast(value) when is_integer(value) or is_float(value), do: {:ok, value}
  def cast(nil), do: {:ok, nil}
  def cast(""), do: {:ok, nil}

  def cast(value) when is_binary(value) do
    case Integer.parse(value) do
      {int, ""} ->
        {:ok, int}

      _ ->
        case Float.parse(value) do
          {float, ""} -> {:ok, float}
          _ -> :error
        end
    end
  end

  def cast(_), do: :error

  @impl true
  def load(value), do: {:ok, value}

  @impl true
  def dump(value) when is_number(value), do: {:ok, value}
  def dump(nil), do: {:ok, nil}
  def dump(_), do: :error
end
