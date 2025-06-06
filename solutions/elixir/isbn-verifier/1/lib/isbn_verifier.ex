defmodule IsbnVerifier do
  @invalid_checksum 550
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn), do: rem(checksum(isbn), 11) == 0

  defp checksum(isbn) do
    checksum = checksum(isbn, 10)
    if checksum < @invalid_checksum, do: checksum, else: 1
  end

  defp checksum(_, 0), do: @invalid_checksum
  defp checksum(<<>>, _), do: @invalid_checksum
  defp checksum(<<?X>>, 1), do: 10
  defp checksum(<<h>>, 1), do: h - ?0
  defp checksum(<<?-, isbn::binary>>, multiplier), do: checksum(isbn, multiplier)
  defp checksum(<<h, isbn::binary>>, multiplier), do: (h - ?0) * multiplier + checksum(isbn, multiplier - 1)

end
