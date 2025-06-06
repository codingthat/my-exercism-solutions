defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2), do: hamming_distance(strand1, strand2, 0)

  @spec hamming_distance([char], [char], non_neg_integer) :: {:ok, non_neg_integer} | {:error, String.t()}
  defp hamming_distance([], [], acc), do: {:ok, acc}
  defp hamming_distance([a | s1], [a | s2], acc), do: hamming_distance(s1, s2, acc)
  defp hamming_distance([_ | s1], [_ | s2], acc), do: hamming_distance(s1, s2, acc + 1)
  defp hamming_distance(_, _, _), do: {:error, "strands must be of equal length"}
end
