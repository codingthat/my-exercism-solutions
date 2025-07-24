defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(z :: complex) :: number
  def real({a, _}), do: a

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(z :: complex) :: number
  def imaginary({_, b}), do: b

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(z1 :: complex | number, z2 :: complex | number) :: complex
  def mul({a, b}, {c, d}), do: {a * c - b * d, b * c + a * d}
  def mul(a, {c, d}), do: {a * c, a * d}
  def mul({a, b}, c), do: {a * c, b * c}

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(z1 :: complex | number, z2 :: complex | number) :: complex
  def add({a, b}, {c, d}), do: {a + c, b + d}
  def add(a, {c, d}), do: {a + c, d}
  def add({a, b}, c), do: {a + c, b}

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(z1 :: complex | number, z2 :: complex | number) :: complex
  def sub({a, b}, {c, d}), do: {a - c, b - d}
  def sub(a, {c, d}), do: {a - c, -d}
  def sub({a, b}, c), do: {a - c, b}

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(z1 :: complex | number, z2 :: complex | number) :: complex
  def div({a, b}, {c, d}),
    do: {(a * c + b * d) / (c * c + d * d), (b * c - a * d) / (c * c + d * d)}

  def div(a, {c, d}), do: {a * c / (c * c + d * d), -a * d / (c * c + d * d)}
  def div({a, b}, c), do: {a / c, b / c}

  @doc """
  Absolute value of a complex number
  """
  @spec abs(z :: complex) :: number
  def abs({a, b}), do: :math.sqrt(a * a + b * b)

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(z :: complex) :: complex
  def conjugate({a, b}), do: {a, -b}

  @doc """
  Exponential of a complex number
  """
  @spec exp(z :: complex) :: complex
  def exp({a, b}),
    do: {
      :math.exp(a) * :math.cos(b),
      :math.exp(a) * :math.sin(b)
    }
end
