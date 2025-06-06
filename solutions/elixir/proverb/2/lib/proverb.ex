defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings) do
    strings
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map_join("", &("For want of a #{hd(&1)} the #{tl(&1)} was lost.\n"))
    |> Kernel.<>("And all for the want of a #{hd(strings)}.\n")
  end
end
