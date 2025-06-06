defmodule DNA do
  @encode %{
    ?\s => 0b000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }
  @decode Map.new(@encode, fn {k, v} -> {v, k} end)

  def encode_nucleotide(code_point), do: @encode[code_point]
  def decode_nucleotide(encoded_code), do: @decode[encoded_code]

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], encoded), do: encoded
  defp do_encode([head | tail], encoded) do
    do_encode(tail, <<encoded::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, decoded), do: decoded
  defp do_decode(<<head::4, tail::bitstring>>, decoded) do
    do_decode(tail, decoded ++ [decode_nucleotide(head)])
  end
end
