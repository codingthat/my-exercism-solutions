defmodule Scrabble do
  @lower_upper_difference ?a - ?A
  @values %{
    [?A, ?E, ?I, ?O, ?U, ?L, ?N, ?R, ?S, ?T] => 1,
    [?D, ?G] => 2,
    [?B, ?C, ?M, ?P] => 3,
    [?F, ?H, ?V, ?W, ?Y] => 4,
    [?K] => 5,
    [?J, ?X] => 8,
    [?Q, ?Z] => 10,
  }
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(""), do: 0
  def score(word), do: word
    |> to_charlist()
    |> Enum.sum_by(&value/1)

  for {letters, value} <- @values, letter <- letters do
    defp value(unquote(letter)), do: unquote(value)
    defp value(unquote(letter + @lower_upper_difference)), do: unquote(value)
  end
  defp value(_), do: 0
end
