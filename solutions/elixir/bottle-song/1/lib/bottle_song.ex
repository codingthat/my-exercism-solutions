defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(_, 0), do: ""
  def recite(start_bottle, 1), do: verse(start_bottle)
  def recite(start_bottle, take_down), do: verse(start_bottle)
    <> "\n\n"
    <> recite(start_bottle - 1, take_down - 1)

  defp verse(count) do
    capitalized = String.capitalize(bottle_phrase(count))
    """
    #{capitalized} hanging on the wall,
    #{capitalized} hanging on the wall,
    And if #{bottle_phrase(1)} should accidentally fall,
    There'll be #{bottle_phrase(count - 1)} hanging on the wall.\
    """
  end

  defp bottle_phrase(1), do: "one green bottle"
  defp bottle_phrase(count), do: "#{longhand(count)} green bottles"

  defp longhand(0), do: "no"
  defp longhand(1), do: "one"
  defp longhand(2), do: "two"
  defp longhand(3), do: "three"
  defp longhand(4), do: "four"
  defp longhand(5), do: "five"
  defp longhand(6), do: "six"
  defp longhand(7), do: "seven"
  defp longhand(8), do: "eight"
  defp longhand(9), do: "nine"
  defp longhand(10), do: "ten"

end
