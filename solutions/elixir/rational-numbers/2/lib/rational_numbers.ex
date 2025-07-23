defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(r1 :: rational, r2 :: rational) :: rational
  def add({a, b}, {c, d}), do: reduce({a * d + b * c, b * d})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(r1 :: rational, r2 :: rational) :: rational
  def subtract({a, b}, {c, d}), do: reduce({a * d - b * c, b * d})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(r1 :: rational, r2 :: rational) :: rational
  def multiply({a, b}, {c, d}), do: reduce({a * c, b * d})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a, b}, {c, d}), do: reduce({a * d, b * c})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({a, b}), do: reduce({Kernel.abs(a), Kernel.abs(b)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0, do: reduce({b ** -n, a ** -n})
  def pow_rational({a, b}, n), do:            reduce({a **  n, b **  n})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, r :: rational) :: float
  def pow_real(x, {a, b}), do: x ** (a / b)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({0, _}), do: {0, 1}
  def reduce({a, a}), do: {1, 1}
  def reduce({a, b}) when b < 0, do: reduce({-a, -b})
  def reduce(r = {a, b}) do
    case Integer.gcd(a, b) do
      1 -> r
      gcd -> {div(a, gcd), div(b, gcd)}
    end
  end
end
