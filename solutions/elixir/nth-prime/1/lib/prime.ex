defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: nth(nil, [], count)
  defp nth(biggest, _, 0), do: biggest
  defp nth(nil, [], remaining), do: nth(2, [], remaining - 1)
  defp nth(2, [], remaining), do: nth(3, [2], remaining - 1)
  defp nth(biggest, rest, remaining) do
    Stream.iterate(biggest + 2, &(&1 + 2))
    |> Enum.find(fn num ->
      Enum.all?(rest, &(rem(num, &1) !== 0))
    end)
    |> then(&(nth(&1, [biggest | rest], remaining - 1)))
  end
end
