defmodule ResistorColorTrio do
  @colours ~w[black brown red orange yellow green blue violet grey white] |> Enum.map(&String.to_atom/1)
  @codes @colours |> Enum.with_index()

  defguardp kilo(c) when c in [:orange, :yellow, :green]
  defguardp kiloblack(c) when c in [:red, :orange, :yellow]
  defguardp mega(c) when c in [:blue, :violet, :grey]
  defguardp megablack(c) when c in [:green, :blue, :violet]
  defguardp giga(c) when c == :white
  defguardp gigablack(c) when c in [:grey, :white]

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([c1, :black, c3 | _]) when gigablack(c3), do: {(@codes[c1] * 10) * 10 ** (@codes[c3] - 9), :gigaohms }
  def label([c1, c2, c3 | _]) when giga(c3), do: {(@codes[c1] * 10 + @codes[c2]) * 10 ** (@codes[c3] - 9), :gigaohms }
  def label([c1, :black, c3 | _]) when megablack(c3), do: {(@codes[c1] * 10) * 10 ** (@codes[c3] - 6), :megaohms }
  def label([c1, c2, c3 | _]) when mega(c3), do: {(@codes[c1] * 10 + @codes[c2]) * 10 ** (@codes[c3] - 6), :megaohms }
  def label([c1, :black, c3 | _]) when kiloblack(c3), do: {(@codes[c1] * 10) * 10 ** (@codes[c3] - 3), :kiloohms }
  def label([c1, c2, c3 | _]) when kilo(c3), do: {(@codes[c1] * 10 + @codes[c2]) * 10 ** (@codes[c3] - 3), :kiloohms }
  def label([c1, c2, c3 | _]), do: {(@codes[c1] * 10 + @codes[c2]) * 10 ** @codes[c3], :ohms}
end
