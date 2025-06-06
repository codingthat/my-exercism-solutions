defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map_join(" ", &translate_word/1)
  end
  defp translate_word(word) do
    case Regex.run(~r/^(xr|yt)?(y)?([^aeiou]*qu)?(([^aeiou]+)(y))?([^aeiou]+)?(.*)$/, word) do
      [_, xr_yt, _, _, _, _, _, _, _]              when xr_yt != ""           -> word
      [_, _, y_start, _, _, _, _, _, rest]         when y_start != ""         -> rest <> "y"
      [_, _, _, qu_and_adjacent, _, _, _, _, rest] when qu_and_adjacent != "" -> rest <> qu_and_adjacent
      [_, _, _, _, _, before_y, _, after_y, rest]  when before_y != ""        -> "y" <> after_y <> rest <> before_y
      [_, _, _, _, _, _, _, consonants, rest]      when consonants != ""      -> rest <> consonants
      [_, _, _, _, _, _, _, _, rest]                                          -> rest
    end |> then(&(&1 <> "ay"))
  end
end
