defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop), do: Enum.map_join(start..stop, "", &verse/1)

  defp verse(number), do: "This is the " <> suffixes(number) <> "\n"

  defp suffixes(0), do: ""
  defp suffixes(number), do: suffix(number) <> suffixes(number - 1)

  defp suffix(1), do: "house that Jack built."
  defp suffix(2), do: "malt that lay in the "
  defp suffix(3), do: "rat that ate the "
  defp suffix(4), do: "cat that killed the "
  defp suffix(5), do: "dog that worried the "
  defp suffix(6), do: "cow with the crumpled horn that tossed the "
  defp suffix(7), do: "maiden all forlorn that milked the "
  defp suffix(8), do: "man all tattered and torn that kissed the "
  defp suffix(9), do: "priest all shaven and shorn that married the "
  defp suffix(10), do: "rooster that crowed in the morn that woke the "
  defp suffix(11), do: "farmer sowing his corn that kept the "
  defp suffix(12), do: "horse and the hound and the horn that belonged to the "
end
