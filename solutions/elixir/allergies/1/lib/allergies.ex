defmodule Allergies do
  import Bitwise, only: [bsr: 2, band: 2]
  defguardp has_first_bit_set(n) when band(n, 1) === 1
  @allergens ["eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"]
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags), do: list_allergens(flags, @allergens, [])

  defp list_allergens(flags, [allergen | allergens], acc)
    when has_first_bit_set(flags), do:
      list_allergens(bsr(flags, 1), allergens, [allergen | acc])
  defp list_allergens(flags, [_allergen | allergens], acc), do:
    list_allergens(bsr(flags, 1), allergens, acc)
  defp list_allergens(_, [], acc), do: acc


  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    index = Enum.find_index(@allergens, &(&1 === item))
    flags
    |> bsr(index)
    |> has_first_bit_set()
  end

end
