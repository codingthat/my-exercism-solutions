defmodule Say do
  @units ~w[one two three four five six seven eight nine]
  @tens ~w[ten twenty thirty forty fifty sixty seventy eighty ninety]
  @scales [{" hundred", 2}
    | Enum.with_index(~w[thousand million billion], fn word, index ->
      {" " <> word, (index + 1) * 3}
    end)]
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(0), do: {:ok, "zero"}
  def in_english(number), do: {:ok, cardinal(number)}

  for {unit, number} <- Enum.with_index(@units, 1) do
    defp cardinal(unquote(number)), do: unquote(unit)
    if number in [4,5,6,7,9] do
      defp cardinal(unquote(10 + number)), do: unquote(unit <> "teen")
    end
  end
  defp cardinal(11), do: "eleven"
  defp cardinal(12), do: "twelve"
  defp cardinal(13), do: "thirteen"
  defp cardinal(18), do: "eighteen"
  for {multiple_of_ten, number} <- Enum.with_index(@tens, 1) do
    defp cardinal(unquote(number * 10)), do: unquote(multiple_of_ten)
  end
  for number <- 21..99, rem(number, 10) != 0 do
    defp cardinal(unquote(number)), do: unquote(
      Enum.at(@tens,div(number, 10)-1)
      <> "-"
      <> Enum.at(@units,rem(number, 10)-1))
  end
  for {{scale_word, magnitude}, index} <- Enum.with_index(@scales) do
    min = 10 ** magnitude - 1
    scale_value = 10 ** magnitude
    max = 10 ** ((index + 1) * 3)
    defp cardinal(number) when number > unquote(min) and number < unquote(max)
      and rem(number, unquote(scale_value)) == 0, do:
        cardinal(div(number, unquote(scale_value))) <> unquote(scale_word)
    defp cardinal(number) when number > unquote(min) and number < unquote(max), do:
      cardinal(div(number, unquote(scale_value))) <> unquote(scale_word)
      <> " " <> cardinal(rem(number, unquote(scale_value)))
  end

end
