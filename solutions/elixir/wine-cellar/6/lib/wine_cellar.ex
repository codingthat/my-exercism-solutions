defmodule WineCellar do
    def explain_colors do
      [
        white: "Fermented without skin contact.",
        red:   "Fermented with skin contact using dark-colored grapes.",
        rose:  "Fermented with some skin contact, but not enough to qualify as a red wine."
      ]
    end

    # mostly dynamic, but not very easy to read
    @aspects [:year, :country]
    for aspect <- @aspects do
      param = Macro.var(aspect, __MODULE__)
      defp unquote(:"filter_by_#{aspect}")(wines, unquote(param))
      defp unquote(:"filter_by_#{aspect}")(wines, nil), do: wines
      defp unquote(:"filter_by_#{aspect}")([], unquote(param)), do: []
      tuple_pattern = case aspect do
        :year    -> quote do {_, unquote(param), _} end
        :country -> quote do {_, _, unquote(param)} end
      end
      defp unquote(:"filter_by_#{aspect}")([unquote(tuple_pattern) = wine | tail], unquote(param)) do
        [wine | unquote(:"filter_by_#{aspect}")(tail, unquote(param))]
      end
      defp unquote(:"filter_by_#{aspect}")([{_, _, _} | tail], unquote(param)) do
        unquote(:"filter_by_#{aspect}")(tail, unquote(param))
      end
    end

    def filter(cellar, color, opts \\ []) do
      Keyword.get_values(cellar, color)
      |> filter_by_year(opts[:year])
      |> filter_by_country(opts[:country])
    end
  end
