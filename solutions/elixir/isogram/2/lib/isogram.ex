defmodule Isogram do
  defguardp upper?(c) when (c >= ?A and c <= ?Z)
  @lower_upper_difference ?a - ?A
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence), do: not contains_repeats?(sentence, %{})

  defp contains_repeats?("", _), do: false
  defp contains_repeats?(<<"-", sentence::binary>>, acc), do: contains_repeats?(sentence, acc)
  defp contains_repeats?(<<" ", sentence::binary>>, acc), do: contains_repeats?(sentence, acc)
  defp contains_repeats?(<<h, sentence::binary>>, acc) when upper?(h) do
    contains_repeats?(<<h + @lower_upper_difference, sentence::binary>>, acc)
  end
  defp contains_repeats?(<<h, sentence::binary>>, acc) do
    if Map.has_key?(acc, h) do
      true
    else
      contains_repeats?(sentence, Map.put(acc, h, 1))
    end
  end

end
