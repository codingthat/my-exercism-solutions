defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(cage)
      when cage.sum < 1 or
             cage.size < 1 or
             cage.sum < div(cage.size * (cage.size + 1), 2) or
             cage.sum > 45 - div((9 - cage.size) * (10 - cage.size), 2),
      do: [[]]

  # below sum range implied by final guard above
  def combinations(cage) when cage.size == 1, do: [[cage.sum]]

  def combinations(cage) do
    for i <- 1..max(min(9, div(cage.sum, 2) - 1), 1), i not in cage.exclude do
      sub_results =
        combinations(%{exclude: [i | cage.exclude], size: cage.size - 1, sum: cage.sum - i})

      if sub_results != [[]] and sub_results != [] do
        Enum.flat_map(sub_results, fn result ->
          MapSet.new([i | result])
        end)
      else
        []
      end
      |> MapSet.new()
    end
    |> Enum.map(&MapSet.to_list/1)
    |> Enum.uniq()
  end
end
