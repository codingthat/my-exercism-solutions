defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    ubase = String.upcase(base)
    candidates
    |> Enum.filter(fn candidate ->
      ucandidate = String.upcase(candidate)
      ucandidate != ubase and split_sort(ucandidate) == split_sort(ubase)
    end)
  end

  defp split_sort(string), do: string |> String.to_charlist() |> Enum.sort() |> Enum.join()
end
