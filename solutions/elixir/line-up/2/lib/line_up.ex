defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    suffix =
      case rem(number, 10) do
        x when x > 3 or x == 0 or rem(number, 100) in 11..13 -> "th"
        1 -> "st"
        2 -> "nd"
        3 -> "rd"
      end

    "#{name}, you are the #{number}#{suffix} customer we serve today. Thank you!"
  end
end
