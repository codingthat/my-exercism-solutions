defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"

    G -> C
    C -> G
    T -> A
    A -> U

  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: rna(dna)

  defp rna(dna), do: rna(dna, [])

  defp rna([], rna), do: Enum.reverse(rna)
  defp rna([?G | t], rna), do: rna(t, [?C | rna])
  defp rna([?C | t], rna), do: rna(t, [?G | rna])
  defp rna([?T | t], rna), do: rna(t, [?A | rna])
  defp rna([?A | t], rna), do: rna(t, [?U | rna])
end
