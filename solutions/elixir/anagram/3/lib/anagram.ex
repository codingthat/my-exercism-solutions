defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    ubase = String.upcase(base)
    cbase = String.to_charlist(ubase)
    candidates |> Enum.filter(fn candidate ->
      ucandidate = String.upcase(candidate)
      ucandidate != ubase and anagram?(cbase, String.to_charlist(ucandidate))
    end)
  end

  defp anagram?(c1, c2) when length(c1) == length(c2), do: c1 -- c2 == []
  defp anagram?(_, _), do: false
end
