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

    for col <- 0..(c - 1),
        row <- 0..(r - 1),
        index = row * c + col,
        into: <<>> do
      if row == r - 1 and col < c - 1 do
        <<padded_at(normalized, size, index), ?\s>>
      else
        <<padded_at(normalized, size, index)>>
      end
    end
  end

  defp padded_at(normalized, size, index) when index < size, do: :binary.at(normalized, index)
  defp padded_at(_, _, _), do: ?\s
end
