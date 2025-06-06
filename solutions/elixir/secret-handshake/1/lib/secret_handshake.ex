defmodule SecretHandshake do
  import Bitwise, only: [&&&: 2, >>>: 2, ~~~: 1]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when (code &&& 16) === 16, do: commands(~~~16 &&& code) |> Enum.reverse()
  def commands(code) do
    Enum.reduce(3..0//-1, [], fn i, acc ->
      bit = (code >>> i) &&& 1
      mapped = case {i, bit} do
        {0, 1} -> "wink"
        {1, 1} -> "double blink"
        {2, 1} -> "close your eyes"
        {3, 1} -> "jump"
        _else -> nil
      end
      if mapped do
        [mapped | acc]
      else
        acc
      end
    end)
  end
end
