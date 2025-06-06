defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"

  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: Enum.map(dna, &rna/1)

  defp rna(?G), do: ?C
  defp rna(?C), do: ?G
  defp rna(?T), do: ?A
  defp rna(?A), do: ?U
end
