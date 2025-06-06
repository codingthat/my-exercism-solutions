defmodule MatchingBrackets do
  @pairs "[]{}()"
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str), do: is_balanced?(str, [])

  defp is_balanced?("", []), do: true
  defp is_balanced?("", _), do: false
  for [opener, closer] <- Enum.chunk_every(String.to_charlist(@pairs), 2) do
    defp is_balanced?(<<unquote(opener), str::binary>>, stack),
      do: is_balanced?(str, [unquote(opener) | stack])
    defp is_balanced?(<<unquote(closer), str::binary>>, [unquote(opener) | stack]),
      do: is_balanced?(str, stack)
    defp is_balanced?(<<unquote(closer), _::binary>>, _),
      do: false
  end
  defp is_balanced?(<<_, str::binary>>, stack), do: is_balanced?(str, stack)
end
