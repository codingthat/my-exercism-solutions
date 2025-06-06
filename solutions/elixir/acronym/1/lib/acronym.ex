defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/([[:alpha:]])[^\s-]*/, string, capture: :all_but_first)
    |> Enum.join()
    |> String.upcase()
  end
end
