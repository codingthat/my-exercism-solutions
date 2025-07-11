defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide), do: count(strand, nucleotide, 0)

  defp count([], _, acc), do: acc
  defp count([h | strand], nucleotide, acc) when h == nucleotide, do: count(strand, nucleotide, acc + 1)
  defp count([_ | strand], nucleotide, acc), do: count(strand, nucleotide, acc)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand), do: histogram(strand, Map.new(@nucleotides, &({&1, 0})))

  defp histogram([], summary), do: summary
  defp histogram([h | strand], summary), do: histogram(strand, Map.update!(summary, h, &(&1 + 1)))

end
