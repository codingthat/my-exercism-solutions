defmodule Gigasecond do
  import NaiveDateTime, only: [from_erl!: 1, add: 2, to_erl: 1]
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from(datetime = {{year, month, day}, {hours, minutes, seconds}}) do
    datetime
    |> from_erl!
    |> add(1_000_000_000)
    |> to_erl
  end
end
