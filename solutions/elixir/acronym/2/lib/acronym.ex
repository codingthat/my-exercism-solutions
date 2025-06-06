defmodule Acronym do
  def abbreviate(string), do: Regex.scan(~r/([[:alpha:]])[^\s-]*/, string, capture: :all_but_first) |> Enum.join() |> String.upcase()
end
