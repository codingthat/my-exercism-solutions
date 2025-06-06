defmodule Username do
  def substitute(char) do
    case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      other -> [other]
    end
  end
  
  def sanitize(username), do: username |> Enum.flat_map(&substitute/1) |> Enum.filter(&(&1 == ?_ or &1 >= ?a and &1 <= ?z))
end
