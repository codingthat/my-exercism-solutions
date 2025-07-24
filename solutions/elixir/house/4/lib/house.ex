defmodule House do
  subjects_and_predicates = [
    {"house", "Jack built."},
    {"malt", "lay in"},
    {"rat", "ate"},
    {"cat", "killed"},
    {"dog", "worried"},
    {"cow with the crumpled horn", "tossed"},
    {"maiden all forlorn", "milked"},
    {"man all tattered and torn", "kissed"},
    {"priest all shaven and shorn", "married"},
    {"rooster", "crowed in the morn that woke"},
    {"farmer sowing his corn", "kept"},
    {"horse and the hound and the horn", "belonged to"}
  ]

  full_verse = fn verse_subjects_and_predicates ->
    verse_subjects_and_predicates
    |> List.foldr(["This is"], fn
      {subject, predicate}, verse ->
        verse ++ [" the ", subject, " that ", predicate]
    end)
    |> then(&(&1 ++ ["\n"]))
    |> :erlang.iolist_to_binary()
  end

  for number <- 1..length(subjects_and_predicates) do
    verse_subjects_and_predicates =
      subjects_and_predicates
      |> Enum.take(number)

    defp verse(unquote(number)), do: unquote(full_verse.(verse_subjects_and_predicates))
  end

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: :erlang.iolist_to_binary(verses(start, stop, []))

  defp verses(start, stop, acc) when start > stop, do: acc
  defp verses(start, stop, acc), do: verses(start, stop - 1, [verse(stop) | acc])
end
