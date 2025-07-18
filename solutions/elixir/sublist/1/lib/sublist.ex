defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) when length(a) > length(b), do: flip_sub(compare_sub(b, a))
  def compare(a, b) when length(b) > length(a), do: compare_sub(a, b)
  def compare(_, _), do: :unequal

  defp compare_sub(_, []), do: :unequal
  defp compare_sub(a, b) when length(a) > length(b), do: :unequal
  defp compare_sub(a, b) do
    if Enum.all?(Enum.zip(a, b), fn {x, y} -> x === y end) do
      :sublist
    else
      [_ | t] = b
      compare_sub(a, t)
    end
  end

  defp flip_sub(:sublist), do: :superlist
  defp flip_sub(other_result), do: other_result
end
