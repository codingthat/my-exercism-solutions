defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers))
  defp search(numbers, key, low, high) do
    middle = div(high-low, 2) + low
    elem = elem(numbers, middle)
    cond do
      key == elem -> {:ok, middle}
      key < elem and middle != high -> search(numbers, key, low, middle)
      key > elem and middle != low -> search(numbers, key, middle, high)
      :else -> :not_found
    end
  end
end
