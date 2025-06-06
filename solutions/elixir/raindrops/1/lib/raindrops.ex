defmodule Raindrops do
  defguardp mult3(n) when rem(n, 3) == 0
  defguardp mult5(n) when rem(n, 5) == 0
  defguardp mult7(n) when rem(n, 7) == 0
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(n) when mult3(n) and mult5(n) and mult7(n), do: "PlingPlangPlong"
  def convert(n) when mult3(n) and mult5(n), do: "PlingPlang"
  def convert(n) when mult3(n) and mult7(n), do: "PlingPlong"
  def convert(n) when mult5(n) and mult7(n), do: "PlangPlong"
  def convert(n) when mult3(n), do: "Pling"
  def convert(n) when mult5(n), do: "Plang"
  def convert(n) when mult7(n), do: "Plong"
  def convert(n), do: to_string(n)
end
