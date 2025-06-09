defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    ~r/[a-zA-Z0-9][a-zA-Z0-9']*[a-zA-Z0-9]|[a-zA-Z0-9]/
    |> Regex.scan(sentence)
    |> Enum.frequencies_by(&hd/1)
  end
end
