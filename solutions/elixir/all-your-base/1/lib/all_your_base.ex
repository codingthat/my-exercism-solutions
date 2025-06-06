defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(digits, input_base, output_base), do:
    do_convert(digits, input_base, output_base, length(digits) - 1, 0)

  defp do_convert([h | _], input_base, _output_base, _index, _acc)
    when h < 0 or h >= input_base, do:
      {:error, "all digits must be >= 0 and < input base"}
  defp do_convert([h | rest], input_base, output_base, index, acc) do
    do_convert(rest, input_base, output_base, index - 1, acc + h * input_base ** index)
  end
  defp do_convert([], _, output_base, _, acc), do: acc
    |> convert_from_decimal(output_base, [])
    |> then(&({:ok, handle_empties(&1)}))

  defp convert_from_decimal(0, _, acc), do: acc
  defp convert_from_decimal(decimal, 10, []), do: Integer.digits(decimal)
  defp convert_from_decimal(decimal, output_base, acc) do
    convert_from_decimal(div(decimal, output_base), output_base, [rem(decimal, output_base) | acc])
  end

  defp handle_empties(list), do: if list == [], do: [0], else: list
end
