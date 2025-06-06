defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  defp find_any(wines, search_for, filter_fn)
  defp find_any(wines, [], _), do: wines
  defp find_any(wines, search_for, filter_fn), do: Enum.flat_map(search_for, &filter_fn.(wines, &1))

  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
    |> find_any(Keyword.get_values(opts, :year), &filter_by_year/2)
    |> find_any(Keyword.get_values(opts, :country), &filter_by_country/2)
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
