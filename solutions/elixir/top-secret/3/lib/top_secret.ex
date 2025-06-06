defmodule TopSecret do
  def decode_secret_message(string), do:
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()

  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({macro_id, _, [first_arg | _]} = ast, acc)
    when macro_id in [:def, :defp] do
      case first_arg do
        {:when, _, [actual_arg_list | _]} -> actual_arg_list
        _ -> first_arg
      end
      |> decode_part_from_arg_list(ast, acc)
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}


  defp decode_part_from_arg_list(arg_list, ast, acc) do
    arity = ((arg_list |> elem(2)) || []) |> length()
    new_acc = if(arity == 0, do: ["" | acc], else:
      [arg_list |> elem(0) |> to_string() |> String.slice(0..arity-1) | acc]
    )
    {ast, new_acc}
  end
end
