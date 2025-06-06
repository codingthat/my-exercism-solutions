defmodule PigLatin do
  defguardp is_vowel?(char) when char in [?a, ?e, ?i, ?o, ?u]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map_join(" ", &translate_word/1)
  end
  # rule 1:
  defp translate_word(word = "xr" <> _), do: word <> "ay"
  defp translate_word(word = "yt" <> _), do: word <> "ay"
  # rules 2-4:
  defp translate_word(word) do
    {moving, core} = moving_core(word)
    core <> moving <> "ay"
  end

  # moving part starts empty
  defp moving_core(word, moving \\ <<>>)

  # moving is capped when the next char is a "y," unless at the start of a word (rule 4)
  defp moving_core(core = <<?y, _::binary>>, moving) when moving != "", do: {moving, core}
  # moving is capped when the next char is a vowel (rules 2-4)
  defp moving_core(core = <<v, _::binary>>, moving) when is_vowel?(v), do: {moving, core}

  # moving keeps growing when the next chars are "qu" (rule 3)
  defp moving_core("qu" <> core, moving), do: moving_core(core, moving <> "qu")
  # moving keeps growing when the next char is a non-vowel (rules 2-4)
  defp moving_core(<<c, core::binary>>, moving) when not is_vowel?(c), do: moving_core(core, moving <> <<c>>)
end
