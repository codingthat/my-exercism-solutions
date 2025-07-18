defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1[:price]))
  def with_missing_price(inventory), do: Enum.filter(inventory, &(&1[:price] == nil))

  def update_names(inventory, old_word, new_word),
    do:
      Enum.map(inventory, fn item ->
        Map.update!(item, :name,
          &String.replace(&1, old_word, new_word))
      end)

  def increase_quantity(item, count),
    do:
      Map.update!(item, :quantity_by_size,
        &Map.new(&1,
          fn {k, v} -> { k, v + count } end
        ))

  def total_quantity(item),
    do:
      item[:quantity_by_size]
      |> Map.values()
      |> Enum.sum()
end
