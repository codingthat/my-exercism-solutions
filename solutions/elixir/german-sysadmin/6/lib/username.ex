defmodule Username do
  def sanitize([char | tail]) do
    case char do
      as_is when as_is == ?_
              or as_is >= ?a and as_is <= ?z
         -> [as_is  | sanitize(tail)]

      ?ä -> [?a, ?e | sanitize(tail)]
      ?ö -> [?o, ?e | sanitize(tail)]
      ?ü -> [?u, ?e | sanitize(tail)]
      ?ß -> [?s, ?s | sanitize(tail)]

      _else        -> sanitize(tail)
    end
  end

  def sanitize([]), do: []
end
