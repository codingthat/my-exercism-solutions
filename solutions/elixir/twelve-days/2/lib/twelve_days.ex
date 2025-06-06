defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{ordinal(number)} day of Christmas my true love gave to me: #{list(number)}."
  end

  defp ordinal(1), do: "first"
  defp ordinal(2), do: "second"
  defp ordinal(3), do: "third"
  defp ordinal(4), do: "fourth"
  defp ordinal(5), do: "fifth"
  defp ordinal(6), do: "sixth"
  defp ordinal(7), do: "seventh"
  defp ordinal(8), do: "eighth"
  defp ordinal(9), do: "ninth"
  defp ordinal(10), do: "tenth"
  defp ordinal(11), do: "eleventh"
  defp ordinal(12), do: "twelfth"

  defp list(1), do: "a Partridge in a Pear Tree"
  defp list(2), do: "two Turtle Doves, and " <> list(1)
  defp list(3), do: "three French Hens, " <> list(2)
  defp list(4), do: "four Calling Birds, " <> list(3)
  defp list(5), do: "five Gold Rings, " <> list(4)
  defp list(6), do: "six Geese-a-Laying, " <> list(5)
  defp list(7), do: "seven Swans-a-Swimming, " <> list(6)
  defp list(8), do: "eight Maids-a-Milking, " <> list(7)
  defp list(9), do: "nine Ladies Dancing, " <> list(8)
  defp list(10), do: "ten Lords-a-Leaping, " <> list(9)
  defp list(11), do: "eleven Pipers Piping, " <> list(10)
  defp list(12), do: "twelve Drummers Drumming, " <> list(11)

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
