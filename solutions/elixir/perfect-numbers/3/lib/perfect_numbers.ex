defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """

#next: do only up to sqrt, use seive, etc...

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    case aliquot(number) do
      ^number -> {:ok, :perfect}
      x when x > number -> {:ok, :abundant}
      _ -> {:ok, :deficient}
    end
  end

  defp aliquot(1), do: 0
  defp aliquot(number) do
    root = ceil(:math.sqrt(number))
    Enum.reduce(2..root-1//1, 1, fn potential_factor, sum ->
      if rem(number, potential_factor) == 0 do
        sum + potential_factor + div(number, potential_factor)
      else
        sum
      end
    end) + if(root*root == number, do: root, else: 0)
  end
end
