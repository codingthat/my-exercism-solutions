defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when a+b<c or a+c<b or b+c<a, do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) do
    index = [a, b, c]
    |> Enum.uniq()
    |> length()
    {:ok, Enum.at([:equilateral, :isosceles, :scalene], index - 1)}
  end
end
