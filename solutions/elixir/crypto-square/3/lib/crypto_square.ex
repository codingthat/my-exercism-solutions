defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str), do: str |> normalize |> squarify

  defp normalize(normalized), do: normalize(normalized, <<>>)

  defp normalize(<<h, t::binary>>, normalized) when h in ?a..?z or h in ?0..?9,
    do: normalize(t, normalized <> <<h>>)

  defp normalize(<<h, t::binary>>, normalized) when h in ?A..?Z,
    do: normalize(t, normalized <> <<h - ?A + ?a>>)

  defp normalize(<<_h, t::binary>>, normalized), do: normalize(t, normalized)

  defp normalize(<<>>, normalized), do: normalized

  defp squarify(normalized) when normalized == <<>>, do: ""

  defp squarify(normalized) do
    size = byte_size(normalized)
    c = ceil(:math.sqrt(size))
    r = if(c * (c - 1) < size, do: c, else: c - 1)

    squarify(normalized, <<>>, 0, size, 0, c, 0, r)
  end

  defp squarify(_normalized, squarified, _index, _size, col, c, row, r)
       when row == r and col == c - 1,
       do: squarified

  defp squarify(normalized, squarified, _index, size, col, c, row, r) when row == r,
    do: squarify(normalized, squarified <> " ", col + 1, size, col + 1, c, 0, r)

  defp squarify(normalized, squarified, index, size, col, c, row, r) when index < size,
    do:
      squarify(
        normalized,
        squarified <> <<:binary.at(normalized, index)>>,
        index + c,
        size,
        col,
        c,
        row + 1,
        r
      )

  defp squarify(normalized, squarified, index, size, col, c, row, r),
    do: squarify(normalized, squarified <> " ", index, size, col, c, row + 1, r)
end
