defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number), do: accumulate_factors(2, number, [], [])

  defp accumulate_factors(number, number, acc, _), do: Enum.reverse([number | acc])
  defp accumulate_factors(divisor, number, acc, single_primes) when rem(number, divisor) == 0 do
    if divisor in single_primes do
      accumulate_factors(divisor, div(number, divisor), [divisor | acc], single_primes)
    else
      accumulate_factors(divisor, div(number, divisor), [divisor | acc], single_primes ++ [divisor])
    end
  end
  defp accumulate_factors(divisor, number, acc, single_primes) do
    # on the next line, "number" as the default short-circuits via the (number, number, acc, _) match
    next_divisor = Enum.find(
      (divisor+1)..ceil(:math.sqrt(number))//1,
      number,
      &(not_factor_of(single_primes, &1))
    )
    accumulate_factors(next_divisor, number, acc, single_primes)
  end

  defp not_factor_of(single_primes, number) do
    not Enum.any?(single_primes, &(rem(&1, number) == 0))
  end
end
