defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {points, letters}, acc ->
      letters
      |> Enum.reduce(acc, fn letter, acc2 ->
        Map.put(acc2, String.downcase(letter), points)
      end)
    end)
  end
end
