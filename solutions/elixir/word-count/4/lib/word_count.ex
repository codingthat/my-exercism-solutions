defmodule WordCount do
  @uc_lc_diff ?a - ?A

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence), do: count(sentence, <<>>, %{})

  defp count(<<h, sentence::binary>>, word, totals) when h in ?a..?z or h in ?0..?9,
    do: count(sentence, word <> <<h>>, totals)

  defp count(<<h, sentence::binary>>, word, totals) when h in ?A..?Z,
    do: count(sentence, word <> <<h + @uc_lc_diff>>, totals)

  defp count(<<?', h, sentence::binary>>, <<>>, totals)
       when h in ?a..?z or h in ?0..?9 or h in ?A..?Z,
       do: count(sentence, <<h>>, totals)

  defp count(<<?', h, sentence::binary>>, word, totals)
       when h in ?a..?z or h in ?0..?9 or h in ?A..?Z,
       do: count(sentence, word <> <<?', h>>, totals)

  defp count(<<_, sentence::binary>>, word, totals),
    do: count(sentence, <<>>, increment_total(totals, word))

  defp count(<<>>, word, totals), do: increment_total(totals, word)

  defp increment_total(totals, <<>>), do: totals

  defp increment_total(totals, word), do: Map.update(totals, word, 1, &(&1 + 1))
end
