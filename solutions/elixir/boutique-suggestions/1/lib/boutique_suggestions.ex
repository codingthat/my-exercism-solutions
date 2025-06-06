defmodule BoutiqueSuggestions do
  defmacro match_top_bottom(), do: quote(do: %{base_color: _, price: _})
  def get_combinations(tops, bottoms, options \\ []) do
    for match_top_bottom() = top <- tops,
      match_top_bottom() = bottom <- bottoms,
      top.base_color !== bottom.base_color,
      top.price + bottom.price < Keyword.get(options, :maximum_price, 100.00),
      do: {top, bottom}
  end
end