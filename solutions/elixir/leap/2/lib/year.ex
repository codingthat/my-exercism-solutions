defmodule Year do
  defguardp divisible_by(year, divisor) when rem(year, divisor) == 0
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) when divisible_by(year, 400), do: true
  def leap_year?(year) when divisible_by(year, 100), do: false
  def leap_year?(year) when divisible_by(year, 4), do: true
  def leap_year?(_year), do: false
end
