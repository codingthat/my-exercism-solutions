defmodule SimpleCipher do
  def encode(plaintext, key), do:  shift(plaintext,  key, &Kernel.+/2)
  def decode(ciphertext, key), do: shift(ciphertext, key, &Kernel.-/2)

  defp shift(text, key, shift_function) do
    text
    |> String.to_charlist()
    |> Enum.zip_with(Stream.cycle(String.to_charlist(key)), fn p, k ->
      mod_lowercase(shift_function.(p, (k - ?a)))
    end)
    |> to_string()
  end

  defp mod_lowercase(c) when c > ?z, do: mod_lowercase(c - 26)
  defp mod_lowercase(c) when c < ?a, do: mod_lowercase(c + 26)
  defp mod_lowercase(c), do: c

  def generate_key(length \\ (100 + :rand.uniform(2_147_483_548))) do
    Stream.repeatedly(fn -> Enum.random(?a..?z) end)
    |> Enum.take(length)
    |> to_string()
  end
end
