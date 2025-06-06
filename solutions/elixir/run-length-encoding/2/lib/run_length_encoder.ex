defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.replace(~r/(([A-Za-z ])\2{1,})/, string, fn _, chars, char ->
      to_string(String.length(chars)) <> char
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/([0-9]+)(.)/, string, fn _, count, char ->
      String.duplicate(char, String.to_integer(count))
    end)
  end
end
