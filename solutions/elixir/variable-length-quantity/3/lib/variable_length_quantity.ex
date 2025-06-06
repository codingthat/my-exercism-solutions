defmodule VariableLengthQuantity do
  import Bitwise, only: [<<<: 2, band: 2, >>>: 2, &&&: 2]
  @max 7
  @highbit 1 <<< @max
  @lowbits @highbit - 1
  defguardp stop(byte) when band(byte, @highbit) == 0

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode([]), do: <<>>
  def encode([0 | t]), do:                                              <<0>> <> encode(t)
  def encode([h | t]), do: encode(h >>> @max, <<0::1, h &&& @lowbits::@max>>) <> encode(t)

  defp encode(0, acc), do: acc
  defp encode(h, acc), do: encode(h >>> @max, <<1::1, h &&& @lowbits::@max, acc::bitstring>>)

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(<<byte>>) when byte < 256 and not stop(byte), do: {:error, "incomplete sequence"}
  def decode(bytes), do: {:ok, decode_valid_bytes(bytes, [], [])}

  @spec decode_valid_bytes(binary, [integer], [bitstring]) :: [integer]
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, []) when stop(byte) do
    [byte | decode_valid_bytes(rest, acc, [])]
  end
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, partials) when stop(byte) do
    [assemble_partials([<<byte::@max>> | partials]) | decode_valid_bytes(rest, acc, [])]
  end
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, partials) do
    decode_valid_bytes(rest, acc, [<<(byte &&& @lowbits)::@max>> | partials])
  end
  defp decode_valid_bytes(<<>>, acc, _), do: acc

  @spec assemble_partials([bitstring]) :: integer
  defp assemble_partials(partials), do:
       Enum.reverse(partials)
    |> Enum.reduce(0, fn <<n::@max>>, acc -> (acc <<< @max) + n end)

end
