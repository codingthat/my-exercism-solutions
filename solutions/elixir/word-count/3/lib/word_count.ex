defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    ~r/[[:alnum:]][[:alnum:]']*[[:alnum:]]|[[:alnum:]]/
    |> Regex.scan(sentence)
    |> Enum.frequencies_by(&(String.downcase(hd(&1))))
  end
end
