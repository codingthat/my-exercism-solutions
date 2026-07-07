defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    pattern = if("-i" in flags, do: String.downcase(pattern), else: pattern)
    multi_file = length(files) > 1

    for file <- files do
      if "-l" in flags do
        if(
          file
          |> File.stream!()
          |> Enum.any?(fn line ->
            matches?(line, pattern, flags)
          end),
          do: file <> "\n"
        )
      else
        file
        |> File.stream!()
        |> Enum.reduce({"", 1}, fn line, {matches, line_number} ->
          if matches?(line, pattern, flags) do
            file_prefix = if(multi_file, do: file <> ":", else: "")
            line_number_prefix = if("-n" in flags, do: to_string(line_number) <> ":", else: "")
            new_matches = matches <> file_prefix <> line_number_prefix <> line
            {new_matches, line_number + 1}
          else
            {matches, line_number + 1}
          end
        end)
        |> elem(0)
      end
    end
    |> Enum.join()
  end

  defp matches?(line, pattern, flags) do
    line_to_test = if("-i" in flags, do: String.downcase(line), else: line)

    result =
      if("-x" in flags,
        do: line_to_test == pattern <> "\n",
        else: String.contains?(line_to_test, pattern)
      )

    if("-v" in flags, do: !result, else: result)
  end
end
