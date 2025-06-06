defmodule MatchingBrackets do
  @pairs "[]{}()"
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str), do: balanced?(str, [])

  defp balanced?("", []), do: true
  defp balanced?("", _), do: false
  for [opener, closer] <- Enum.chunk_every(String.to_charlist(@pairs), 2) do
    defp balanced?(<<unquote(opener), str::binary>>, stack),
      do: balanced?(str, [unquote(opener) | stack])
    defp balanced?(<<unquote(closer), str::binary>>, [unquote(opener) | stack]),
      do: balanced?(str, stack)
    defp balanced?(<<unquote(closer), _::binary>>, _),
      do: false
  end
  defp balanced?(<<_, str::binary>>, stack), do: balanced?(str, stack)
end
