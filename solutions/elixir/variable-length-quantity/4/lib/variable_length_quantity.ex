defmodule VariableLengthQuantity do
  import Bitwise, only: [<<<: 2, >>>: 2, &&&: 2, |||: 2]
  @max 7
  @highbit 1 <<< @max
  @lowbits @highbit - 1

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
  def decode(bytes), do: decode(bytes, 0, [])

  defp decode(<<0::1, lower::7>>, current, integers), do:
    {:ok, Enum.reverse([current <<< @max ||| lower | integers])}
  defp decode(<<1::1, _::7>>, _, _), do:
    {:error, "incomplete sequence"}
  # try vs. rest::bytes to see if there's any difference
  defp decode(<<0::1, lower::7, rest::binary>>, current, integers), do:
    decode(rest, 0, [current <<< @max ||| lower | integers])
  defp decode(<<1::1, lower::7, rest::binary>>, current, integers), do:
    decode(rest, current <<< @max ||| lower, integers)

end
