defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) when str == "", do: ""

  def encode(str),
    do:
      str
      |> String.downcase()
      |> to_charlist()
      |> reverse_normalize([])
      |> squarify

  defp reverse_normalize([h | t], acc) when (h >= ?a and h <= ?z) or (h >= ?0 and h <= ?9),
    do: reverse_normalize(t, [h | acc])

  defp reverse_normalize([_h | t], acc), do: reverse_normalize(t, acc)
  defp reverse_normalize([], acc), do: acc

  defp squarify(reversed) when reversed == [], do: ""

  defp squarify(reversed) do
    size = length(reversed)
    short_or_exact_side = trunc(:math.sqrt(size))

    padding =
      case size - short_or_exact_side * short_or_exact_side do
        0 -> 0
        x when x < short_or_exact_side -> short_or_exact_side - x
        x -> short_or_exact_side * 2 + 1 - x
      end

    padded =
      (List.duplicate(?\s, padding) ++ reversed)
      |> Enum.reverse()

    Enum.chunk_every(padded, short_or_exact_side + if(padding > 0, do: 1, else: 0))
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.join(" ")
  end
end
