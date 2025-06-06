defmodule Pangram do
  defguardp upper?(c) when (c >= ?A and c <= ?Z)
  defguardp lower?(c) when (c >= ?a and c <= ?z)
  @lower_upper_difference ?a - ?A

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence), do: (map_size(lc_frequencies(to_charlist(sentence), %{})) == 26)

  defp lc_frequencies([], acc), do: acc
  defp lc_frequencies([h | sentence], acc) when lower?(h) do
    lc_frequencies(sentence, Map.put(acc, h, 1))
  end
  defp lc_frequencies([h | sentence], acc) when upper?(h) do
    lc_frequencies(sentence, Map.put(acc, h + @lower_upper_difference, 1))
  end
  defp lc_frequencies([h | sentence], acc), do: lc_frequencies(sentence, acc)
end
