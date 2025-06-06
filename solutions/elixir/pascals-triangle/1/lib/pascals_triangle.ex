defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    for row_number <- 1..num do
      row(row_number)
    end
  end

  defp row(1), do: [1]
  defp row(r) do
    prev = [0 | row(r-1)] ++ [0] |> List.to_tuple()
    for c <- 1..r do
      elem(prev, c-1) + elem(prev, c)
    end
  end
end
