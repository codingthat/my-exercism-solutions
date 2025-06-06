defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) when length(a) > length(b), do: superify_sub(sublist?(b, a))
  def compare(a, b) when length(b) > length(a), do:              sublist?(a, b)
  def compare(_, _), do: :unequal

  defp sublist?(a, b) when length(a) > length(b), do: :unequal
  defp sublist?(a, b) do
    if List.starts_with?(b, a) do
      :sublist
    else
      sublist?(a, tl(b))
    end
  end

  defp superify_sub(:sublist), do: :superlist
  defp superify_sub(other_result), do: other_result
end
