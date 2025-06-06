defmodule Acronym do
  defguardp upper?(c) when (c >= ?A and c <= ?Z)
  defguardp lower?(c) when (c >= ?a and c <= ?z)
  defguardp word_part?(c) when c == ?' or upper?(c) or lower?(c)
  @lower_upper_difference ?a - ?A

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(phrase), do: acronym(phrase, [], :seeking_word)

  defp acronym(<<c::utf8, phrase::binary>>, initials, :seeking_word) when upper?(c) do
    acronym(phrase, [c | initials], :in_word)
  end
  defp acronym(<<c::utf8, phrase::binary>>, initials, :seeking_word) when lower?(c) do
    acronym(phrase, [(c - @lower_upper_difference) | initials], :in_word)
  end
  defp acronym(<<_::utf8, phrase::binary>>, initials, :seeking_word) do
    acronym(phrase, initials, :seeking_word)
  end

  defp acronym(<<c::utf8, phrase::binary>>, initials, :in_word) when word_part?(c) do
    acronym(phrase, initials, :in_word)
  end
  defp acronym(<<_::utf8, phrase::binary>>, initials, :in_word) do
    acronym(phrase, initials, :seeking_word)
  end

  defp acronym(_, initials, _), do: initials |> Enum.reverse() |> List.to_string()
end
