defmodule ResistorColorTrio do
  @colours ~w[black brown red orange yellow green blue violet grey white] |> Enum.map(&String.to_atom/1)
  @codes @colours |> Enum.with_index()
  for { prefix, index } <- Enum.with_index(["kilo", "mega", "giga"]) do
    shift = (index + 1) *3
    rainbow_list = Enum.slice(@colours, shift    , 3)
    black_list =   Enum.slice(@colours, shift - 1, 3)
    defguardp unquote(String.to_atom(prefix))(c) when c in unquote(rainbow_list)
    defguardp unquote(String.to_atom(prefix <> "black"))(c) when c in unquote(black_list)
  end

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  for { prefix, index } <- Enum.with_index(["kilo", "mega", "giga"]) do
    unit = String.to_atom(prefix <> "ohms")
    shift = (index + 1) *3
    def label([c1, :black, c3 | _])
      when unquote(String.to_atom(prefix <> "black"))(c3), do:
        {(@codes[c1] * 10             ) * 10 ** (@codes[c3] - unquote(shift)), unquote(unit) }
    def label([c1, c2, c3 | _])
      when unquote(String.to_atom(prefix))(c3), do:
        {(@codes[c1] * 10 + @codes[c2]) * 10 ** (@codes[c3] - unquote(shift)), unquote(unit) }
  end
  def label([c1, c2, c3 | _]), do: {(@codes[c1] * 10 + @codes[c2]) * 10 ** @codes[c3], :ohms}
end
