defmodule IsbnVerifier do
  defmacrop val(digit) do
    quote do unquote(digit) - ?0 end
  end
  @doc """
    Cdigitecks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn), do: isbn?(isbn, 10, 0)

  defp isbn?(<<?-, isbn::binary>>, mult, sum), do:    isbn?(isbn, mult, sum)
  defp isbn?(<<?X>>, 1, sum), do:                           valid_checksum?(sum + 10)
  defp isbn?(<<digit>>, 1, sum), do:                        valid_checksum?(sum + val(digit))
  defp isbn?(<<digit, isbn::binary>>, mult, sum), do: isbn?(isbn, mult - 1, sum + val(digit) * mult)
  defp isbn?(_, _, _), do: false

  defp valid_checksum?(sum), do: rem(sum, 11) == 0

end
