defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: Enum.map(1..num, &row/1)

  defp row(1), do: [1]
  defp row(2), do: [1, 1]
  defp row(r) do
    prev = row(r-1) |> List.to_tuple()
    [1 | for c <- 2..r-1 do
      elem(prev, c-2) + elem(prev, c-1)
    end] ++ [1]
  end
end
