defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part(ast, acc) do
    if is_tuple(ast) and elem(ast, 0) in [:def, :defp] do
      third_elements_first_element = ast |> elem(2) |> Enum.at(0)
      arg_list = if(third_elements_first_element |> elem(0) == :when,
        do: third_elements_first_element |> elem(2) |> Enum.at(0),
        else: third_elements_first_element
      )
      n = ((arg_list |> elem(2)) || []) |> length()
      new_acc = if(n == 0, do: ["" | acc], else:
        [arg_list |> elem(0) |> to_string() |> String.slice(0..n-1) | acc]
      )
      {ast, new_acc}
    else
      {ast, acc}
    end
  end

  def decode_secret_message(string), do:
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
end
