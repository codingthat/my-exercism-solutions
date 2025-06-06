defmodule VariableLengthQuantity do
  import Bitwise
  @max 7
  @highbit 1 <<< @max
  @lowbits @highbit - 1
  defguardp stop(byte) when band(byte, @highbit) == 0

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode([integer]) do
    get_list(integer)
    |> Enum.reverse()
    |> set_high_bits()
    |> :binary.list_to_bin()
  end
  def encode([integer | rest]), do: encode([integer]) <> encode(rest)

  @spec get_list(integer :: integer) :: [integer]
  defp get_list(integer) do
    first = integer >>> @max
    rest = integer &&& @lowbits
    if first == 0 do
      [rest]
    else
      [rest | get_list(first)]
    end
  end

  @spec set_high_bits(bytes :: [byte]) :: [byte]
  defp set_high_bits([t]), do: [t]
  defp set_high_bits([h | t]), do: [h ||| @highbit | set_high_bits(t)]


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
