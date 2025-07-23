defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a, b) do
    {
      elem(a, 0) * elem(b, 1) + elem(b, 0) * elem(a, 1),
      elem(a, 1) * elem(b, 1)
    }
    |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, b) do
    {
      elem(a, 0) * elem(b, 1) - elem(b, 0) * elem(a, 1),
      elem(a, 1) * elem(b, 1)
    }
    |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a, b) do
    {
      elem(a, 0) * elem(b, 0),
      elem(a, 1) * elem(b, 1)
    }
    |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, den) do
    {
      elem(num, 0) * elem(den, 1),
      elem(den, 0) * elem(num, 1)
    }
    |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a) do
    gcd = Integer.gcd(elem(a, 0), elem(a, 1))
    {Kernel.abs(elem(a, 0)) / gcd, Kernel.abs(elem(a, 1)) / gcd}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a, n) when n < 0 do
    m = Kernel.abs(n)

    {elem(a, 1) ** m, elem(a, 0) ** m}
    |> reduce()
  end

  def pow_rational(a, n) do
    {elem(a, 0) ** n, elem(a, 1) ** n}
    |> reduce()
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n), do: x ** (elem(n, 0) / elem(n, 1))

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    sign_fixer = if(elem(a, 1) < 0, do: -1, else: 1)
    gcd = Integer.gcd(elem(a, 0), elem(a, 1))
    {elem(a, 0) / gcd * sign_fixer, elem(a, 1) / gcd * sign_fixer}
  end
end
