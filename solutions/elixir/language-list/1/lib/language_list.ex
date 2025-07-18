defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove(list), do: List.delete_at(list, 0)
  def first(list), do: hd(list)
  def count(list), do: length(list)
  def functional_list?(list), do: "Elixir" in list
end
