defmodule KitchenCalculator do
  def get_volume(volume_pair), do: elem(volume_pair, 1)
  def to_milliliter({:cup, cups}), do: {:milliliter, cups * 240.0}
  def to_milliliter({:fluid_ounce, fluid_ounces}), do: {:milliliter, fluid_ounces * 30.0}
  def to_milliliter({:teaspoon, teaspoons}), do: {:milliliter, teaspoons * 5.0}
  def to_milliliter({:tablespoon, tablespoons}), do: {:milliliter, tablespoons * 15.0}
  def to_milliliter({:milliliter, milliliters}), do: {:milliliter, milliliters}
  def from_milliliter({:milliliter, milliliters}, :cup), do: {:cup, milliliters / 240.0}
  def from_milliliter({:milliliter, milliliters}, :fluid_ounce), do: {:fluid_ounce, milliliters / 30.0}
  def from_milliliter({:milliliter, milliliters}, :teaspoon), do: {:teaspoon, milliliters / 5.0}
  def from_milliliter({:milliliter, milliliters}, :tablespoon), do: {:tablespoon, milliliters / 15.0}
  def from_milliliter({:milliliter, milliliters}, :milliliter), do: {:milliliter, milliliters}
  def convert(volume_pair, unit), do: from_milliliter(to_milliliter(volume_pair), unit)
end
