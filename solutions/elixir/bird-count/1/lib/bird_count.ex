defmodule BirdCount do
  def today(list), do: List.first(list)
  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]
  def has_day_without_birds?(list), do: 0 in list
  def total(list), do: Enum.sum(list)
  def busy_days(list), do: Enum.count(list, &(&1 >= 5))
end
