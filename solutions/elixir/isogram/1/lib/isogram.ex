defmodule Isogram do
  defguardp upper?(c) when (c >= ?A and c <= ?Z)
  @lower_upper_difference ?a - ?A
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence), do: not isogram_contains?(sentence, %{})

  defp isogram_contains?("", _), do: false
  defp isogram_contains?(<<"-", sentence::binary>>, letters), do: isogram_contains?(sentence, letters)
  defp isogram_contains?(<<" ", sentence::binary>>, letters), do: isogram_contains?(sentence, letters)
  defp isogram_contains?(<<h, sentence::binary>>, letters) when upper?(h) do
    isogram_contains?(<<h + @lower_upper_difference, sentence::binary>>, letters)
  end
  defp isogram_contains?(<<h, sentence::binary>>, letters) do
    if Map.has_key?(letters, h) do
      true
    else
      isogram_contains?(sentence, Map.put(letters, h, 1))
    end
  end

end
