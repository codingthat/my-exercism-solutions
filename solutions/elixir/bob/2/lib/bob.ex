defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    has_letters? = input =~ ~r/\p{L}/u
    is_upcase? = has_letters? and String.upcase(input) == input
    trim = String.trim(input)
    is_question? = String.last(trim) == "?"
    cond do
      trim == "" -> "Fine. Be that way!"
      is_upcase? and is_question? -> "Calm down, I know what I'm doing!"
      is_upcase? -> "Whoa, chill out!"
      is_question? -> "Sure."
      true -> "Whatever."
    end
  end
end
