defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when number < 1 or number > 64, do:
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  def square(number), do: {:ok, Integer.pow(2, number - 1)}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total, do: {:ok, total(64)}

  defp total(1), do: 1
  defp total(square_number), do: elem(square(square_number), 1) + total(square_number - 1)
end
