defmodule KillerSudokuHelper do
  import Bitwise, only: [<<<: 2, >>>: 2, bxor: 2, &&&: 2, |||: 2]

  defguardp valid_doubled_sum(doubled_sum, size)
            when doubled_sum >= size * (size + 1) and
                   doubled_sum <= 90 - (9 - size) * (10 - size)

  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage) when valid_doubled_sum(cage.sum * 2, cage.size) do
    exclude = Enum.sum_by(cage.exclude, fn n -> 2 ** (n - 1) end)
    start = 2 ** cage.size - 1
    combinations(exclude, cage.sum, start, [])
  end

  defp combinations(exclude, sum, n, acc) do
    acc =
      if (n &&& exclude) == 0 and sum(n) == sum do
        [for(i <- 0..8, (n &&& 1 <<< i) != 0, do: i + 1) | acc]
      else
        acc
      end

    # use Gosper’s hack to generate the next bitstring with the same popcount
    c = n &&& -n
    r = n + c
    next = (bxor(r, n) >>> 2) |> div(c) ||| r

    if next > n and next < 512 do
      combinations(exclude, sum, next, acc)
    else
      acc
    end
  end

  defp sum(combination) do
    Enum.reduce(0..8, 0, fn i, acc ->
      if (combination &&& 1 <<< i) != 0, do: acc + (i + 1), else: acc
    end)
  end
end
