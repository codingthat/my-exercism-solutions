defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    filter_by_aspect = fn wines, aspect, filter_fn ->
      Keyword.get_values(opts, aspect)
      |> maybe_filter(wines, filter_fn)
    end
    Keyword.get_values(cellar, color)
    |> filter_by_aspect.(:year, &filter_by_year/2)
    |> filter_by_aspect.(:country, &filter_by_country/2)
  end

  defp maybe_filter(values, wines, filter_fn)
  defp maybe_filter([], wines, _), do: wines
  defp maybe_filter([value], wines, filter_fn), do: filter_fn.(wines, value)
  defp maybe_filter(values, wines, filter_fn) do
    Enum.flat_map(values, &filter_fn.(wines, &1))
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
