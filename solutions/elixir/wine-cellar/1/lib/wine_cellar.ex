defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red:   "Fermented with skin contact using dark-colored grapes.",
      rose:  "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    wines = Keyword.filter(cellar, fn {key, _val} -> key == color end) |> Keyword.values()
    Enum.reduce(opts, wines, fn {key, val}, acc ->
      # apply(__MODULE__, :"filter_by_#{key}", [acc, val]) # no dice: https://stackoverflow.com/questions/28929866/elixir-call-private-function-dynamically
      case key do
        :year    -> filter_by_year(acc, val)
        :country -> filter_by_country(acc, val)
      end
    end)
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
