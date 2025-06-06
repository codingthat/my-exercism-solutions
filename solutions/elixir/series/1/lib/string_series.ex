defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1, do: []
  def slices(s, size) when size > byte_size(s), do: []
  def slices(s, size) do
    s
    |> to_charlist()
    |> Enum.reduce([], &(shift_window(size, &1, &2)))
    |> Enum.reverse()
  end

  # TODO: this must be cleaner with streams.  will return.
  defp shift_window(_, char, []), do: [<<char>>]
  defp shift_window(size, char, acc) do
    if String.length(hd(acc)) == size do
      <<_extra, new_substring::binary>> = hd(acc)
      [(new_substring <> <<char::utf8>>) | acc]
    else
      List.update_at(acc, 0, &(&1 <> <<char::utf8>>))
    end
  end
end
