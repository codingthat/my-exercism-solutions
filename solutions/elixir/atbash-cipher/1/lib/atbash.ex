defmodule Atbash do
  defguardp lower?(c) when c >= ?a and c <= ?z
  defguardp digit?(c) when c >= ?0 and c <= ?9

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> to_charlist()
    |> Enum.filter(&allowed?/1)
    |> Enum.map(&encoded_char/1)
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  defp allowed?(c) when lower?(c) or digit?(c), do: true
  defp allowed?(_), do: false

  defp encoded_char(c) when lower?(c), do: <<(25 - (c - ?a)) + ?a>>
  defp encoded_char(c), do: <<c>>

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> to_charlist()
    |> Enum.filter(&allowed?/1)
    |> Enum.map(&encoded_char/1)
    |> Enum.join()
  end
end
