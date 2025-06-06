defmodule Gigasecond do
  import NaiveDateTime, only: [new!: 6, add: 2]
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    %NaiveDateTime{
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second
    } = add(new!(year, month, day, hours, minutes, seconds), 1_000_000_000)
    {{year, month, day}, {hour, minute, second}}
  end
end
