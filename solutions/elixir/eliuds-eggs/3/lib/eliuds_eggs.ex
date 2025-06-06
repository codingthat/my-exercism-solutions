defmodule EliudsEggs do
  import Bitwise, only: [>>>: 2, &&&: 2]
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0), do: 0
  def egg_count(n), do: (n &&& 1) + egg_count(n >>> 1)
end
