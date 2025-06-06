defmodule RomanNumerals do
  @mapping [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"},
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: roman(number)

  defp roman(n), do: roman(n, "")
  defp roman(0, acc), do: acc
  for {min, roman} <- @mapping do
    defp roman(n, acc) when n >= unquote(min), do: roman(n - unquote(min), acc <> unquote(roman))
  end
end
