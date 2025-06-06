defmodule BasketballWebsite do
  def extract_from_path(data, path), do: String.split(path, ".") |> do_extract_from_keys(data)

  defp do_extract_from_keys([last_key], data), do: data[last_key]
  defp do_extract_from_keys([head | rest], data), do: do_extract_from_keys(rest, data[head])

  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
