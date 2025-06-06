defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) when length(b) > length(a), do: sublist?(a, b)
  def compare(a, b) when length(a) > length(b), do: sublist?(b, a, true)
  def compare(_, _), do: :unequal

  defp sublist?(a, b, reversed \\ false)
  defp sublist?(a, b, _) when length(a) > length(b), do: :unequal
  defp sublist?(a, b, reversed) do
    if List.starts_with?(b, a) do
      if(reversed, do: :superlist, else: :sublist)
    else
      sublist?(a, tl(b), reversed)
    end
  end
end
