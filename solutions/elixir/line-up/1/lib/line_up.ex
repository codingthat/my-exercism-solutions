defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number),
    do:
      name <>
        ", you are the " <>
        Integer.to_string(number) <>
        ordinal(number) <>
        " customer we serve today. Thank you!"

  defp ordinal(number) when rem(number, 10) == 1 and not (rem(number, 100) == 11), do: "st"
  defp ordinal(number) when rem(number, 10) == 2 and not (rem(number, 100) == 12), do: "nd"
  defp ordinal(number) when rem(number, 10) == 3 and not (rem(number, 100) == 13), do: "rd"
  defp ordinal(_), do: "th"
end
