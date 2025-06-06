defmodule Acronym do
  defguardp upper(c) when (c >= ?A and c <= ?Z)
  defguardp lower(c) when (c >= ?a and c <= ?z)
  defguardp word_part(c) when c == ?' or upper(c) or lower(c)
  @lower_upper_difference ?a - ?A

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string), do: do_abbreviate(string, [], :seeking_word)

  defp do_abbreviate(<<c::utf8, rest::binary>>, initials, :seeking_word) when upper(c) do
    do_abbreviate(rest, [c | initials], :in_word)
  end
  defp do_abbreviate(<<c::utf8, rest::binary>>, initials, :seeking_word) when lower(c) do
    do_abbreviate(rest, [(c - @lower_upper_difference) | initials], :in_word)
  end
  defp do_abbreviate(<<_::utf8, rest::binary>>, initials, :seeking_word) do
    do_abbreviate(rest, initials, :seeking_word)
  end

  defp do_abbreviate(<<c::utf8, rest::binary>>, initials, :in_word) when word_part(c) do
    do_abbreviate(rest, initials, :in_word)
  end
  defp do_abbreviate(<<_::utf8, rest::binary>>, initials, :in_word) do
    do_abbreviate(rest, initials, :seeking_word)
  end

  defp do_abbreviate(_, initials, _), do: initials |> Enum.reverse() |> List.to_string()
end
