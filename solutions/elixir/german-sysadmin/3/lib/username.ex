defmodule Username do
  defp sanitize_char(char) do
    case char do
      as_is when as_is == ?_
              or as_is in ?a..?z -> [as_is]
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      nope -> []
    end
  end
  
  def sanitize(username), do: username |> Enum.flat_map(&sanitize_char/1)
end
