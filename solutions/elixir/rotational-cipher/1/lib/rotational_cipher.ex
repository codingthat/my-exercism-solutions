defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&(rotate_letter(&1, shift)))
    |> to_string()
  end

  for {start, stop} <- [{?A, ?Z}, {?a, ?z}], letter <- start..stop do
    defp rotate_letter(unquote(letter), shift),
      do: rem(unquote(letter) - unquote(start) + shift, 26) + unquote(start)
  end
  defp rotate_letter(non_letter, _), do: non_letter
end
