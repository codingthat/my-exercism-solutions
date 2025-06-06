defmodule Pangram do
  import Bitwise, only: [<<<: 2, |||: 2]
  @all_chars_set 2 ** 26 - 1
  @lower_upper_difference ?a - ?A

  @spec pangram?(String.t()) :: boolean()
  def pangram?(sentence) do
    all_chars_included?(sentence, 0)
  end

  defp all_chars_included?(_, @all_chars_set), do: true

  defp all_chars_included?(sentence, chars_included) do
    if chars_included == @all_chars_set do
      true
    else
      scan(sentence, chars_included)
    end
  end

  Enum.each(?a..?z, fn lower ->
    bit = 1 <<< (lower - ?a)
    upper = lower - @lower_upper_difference

    defp scan(<<unquote(lower), sentence::binary>>, chars_included),
      do: all_chars_included?(sentence, chars_included ||| unquote(bit))
    defp scan(<<unquote(upper), sentence::binary>>, chars_included),
      do: all_chars_included?(sentence, chars_included ||| unquote(bit))
  end)
  defp scan(<<_::8, rest::binary>>, chars), do: all_chars_included?(rest, chars)
  defp scan(<<>>, _), do: false
end
