defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    case :math.sqrt(x*x + y*y) do
      x when x > 10 -> 0
      x when x > 5  -> 1
      x when x > 1  -> 5
      _else        -> 10
    end
  end
end
