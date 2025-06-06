defmodule VariableLengthQuantity do
  import Bitwise
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

  defp get_list(integer) do
    first = integer >>> 7
    rest = (integer &&& 127)
    if first == 0 do
      [rest]
    else
      [rest | get_list(first)]
    end
  end

  @spec set_high_bits(bytes :: [byte]) :: [byte]
  defp set_high_bits([t]), do: [t]
  defp set_high_bits([h | t]), do: [h ||| 128 | set_high_bits(t)]


  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(<<byte>>) when byte < 256 and band(byte, 128) != 0, do: {:error, "incomplete sequence"}
  def decode(bytes) do
    {:ok, decode_valid_bytes(bytes)}
  end

  defp decode_valid_bytes(bytes), do: decode_valid_bytes(bytes, [], [])

  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, []) when (byte &&& 128) == 0 do
    [byte | decode_valid_bytes(rest, acc, [])]
  end
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, []) when (byte &&& 128) != 0 do
    decode_valid_bytes(rest, acc, [<<(byte &&& 127)::7>>])
  end
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, partials) when (byte &&& 128) == 0 do
    [reverse_assemble_partials([<<byte::7>> | partials]) | decode_valid_bytes(rest, acc, [])]
  end
  defp decode_valid_bytes(<<byte::8, rest::binary>>, acc, partials) when (byte &&& 128) != 0 do
    decode_valid_bytes(rest, acc, [<<(byte &&& 127)::7>> | partials])
  end
  defp decode_valid_bytes(<<>>, acc, _), do: acc

  defp reverse_assemble_partials(partials), do: Enum.reverse(partials)
    |> Enum.map(fn <<n::7>> -> n end)
    |> Enum.reduce(0, fn part, acc -> (acc <<< 7) + part end)

end
