defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @domino_bit_size 3

  # counts of each domino type
  # 112123123412345123456
  # x x  x   x    x     x
  # 012345678901234567890
  # follows OEIS A002260 (but zero-based because it's a tuple)
  @zero_counts {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?(dominoes) do
    with choices <- List.foldl(dominoes, @zero_counts, &add_choice/2) do
      build_chain?(choices)
    end
  end

  # create counts of choices
  # forward with build_chain: take first non-dead-end-producing choice in each list repeatedly
  #   all lists empty, and valid? true
  #   otherwise:
  #     backtrack: rebuild choice lists until one would have two DIFFERENT options, then:
  #       add preexisting choice as would-be-partial-string to dead ends
  #       add new different option
  #       forward again but taking new different option
  #     otherwise (i.e., undid the whole thing without finding a new choice): false

  defp add_choice({n1, n2}, acc), do: update_tuple(acc, i(n1, n2), &(&1 + 1))

  defp update_tuple(tuple, idx, fun) do
    put_elem(tuple, idx, fun.(elem(tuple, idx)))
  end

  defp i(n, n), do: div(n * (n + 1), 2) - 1
  defp i(n1, n2) when n2 > n1, do: i(n2, n1)
  defp i(n1, n2), do: i(n1 - 1, n1 - 1) + n2

  defp build_chain?(choices, chain \\ <<>>, dead_ends \\ [])

  defp build_chain?(@zero_counts, <<>>, _), do: true
  defp build_chain?(@zero_counts, <<_::@domino_bit_size>>, _), do: true

  defp build_chain?(@zero_counts, chain, dead_ends) do
    middle_size = bit_size(chain) - @domino_bit_size * 2

    <<last::@domino_bit_size, _::bitstring-size(^middle_size), first::@domino_bit_size>> = chain

    first == last || backtrack?(@zero_counts, chain, dead_ends)
  end

  defp build_chain?(choices, chain, dead_ends) do
    case next_viable(choices, chain, dead_ends) do
      nil ->
        backtrack?(choices, chain, dead_ends)

      {new_choices, new_chain} ->
        build_chain?(new_choices, new_chain, dead_ends)
    end
  end

  defp next_viable(choices, chain, dead_ends)
  defp next_viable(choices, <<>>, dead_ends), do: first_viable(choices, dead_ends, 0)

  defp next_viable(choices, <<prev_number::@domino_bit_size, _::bitstring>> = chain, dead_ends),
    do: next_viable(choices, chain, dead_ends, prev_number)

  defp first_viable(choices, dead_ends, i)

  defp first_viable(_, _, i) when i >= tuple_size(@zero_counts), do: nil

  defp first_viable(choices, dead_ends, i) when elem(choices, i) == 0,
    do: first_viable(choices, dead_ends, i + 1)

  defp first_viable(choices, dead_ends, i) do
    {prev_number, next_number} = numbers_from_index(i)
    new_chain = <<next_number::@domino_bit_size, prev_number::@domino_bit_size>>

    case Enum.member?(dead_ends, new_chain) do
      true -> first_viable(choices, dead_ends, i + 1)
      false -> {update_tuple(choices, i, &(&1 - 1)), new_chain}
    end
  end

  # todo: turn the following into metaprogramming
  # Enum.scan(1..5, fn element, acc -> element + acc end)
  # [1, 3, 6, 10, 15]
  defp numbers_from_index(i) when i < 1, do: {1, 1}
  defp numbers_from_index(i) when i < 3, do: {2, i}
  defp numbers_from_index(i) when i < 6, do: {3, i - 2}
  defp numbers_from_index(i) when i < 10, do: {4, i - 5}
  defp numbers_from_index(i) when i < 15, do: {5, i - 9}
  defp numbers_from_index(i) when i < 21, do: {6, i - 14}

  defp next_viable(choices, chain, dead_ends, n1, n2 \\ 1) do
    next_viable(choices, chain, dead_ends, n1, n2, i(n1, n2))
  end

  defp next_viable(choices, chain, dead_ends, n1, n2, i)

  defp next_viable(_, _, _, _, _, i) when i >= tuple_size(@zero_counts), do: nil

  defp next_viable(choices, chain, dead_ends, n1, n2, i) when elem(choices, i) == 0,
    do: next_viable(choices, chain, dead_ends, n1, n2 + 1)

  defp next_viable(choices, chain, dead_ends, n1, n2, i) do
    new_chain = <<n2::@domino_bit_size, chain::bitstring>>

    case Enum.member?(dead_ends, new_chain) do
      true -> next_viable(choices, chain, dead_ends, n1, n2 + 1)
      false -> {update_tuple(choices, i, &(&1 - 1)), new_chain}
    end
  end

  defp backtrack?(@zero_counts, _, _), do: false

  defp backtrack?(choices, <<n1::@domino_bit_size, rest::bitstring>> = chain, dead_ends) do
    <<n2::@domino_bit_size, first_if_empty::bitstring>> = rest
    i = i(n1, n2)

    if first_if_empty == <<>> do
      new_dead_ends = [chain | dead_ends]

      case first_viable(update_tuple(choices, i, &(&1 + 1)), new_dead_ends, i + 1) do
        nil ->
          false

        {new_choices, new_chain} ->
          build_chain?(new_choices, new_chain, new_dead_ends)
      end
    else
      case next_viable(choices, chain, dead_ends, n1) do
        nil ->
          backtrack?(update_tuple(choices, i, &(&1 + 1)), rest, dead_ends)

        {_, dead_end} ->
          backtrack?(update_tuple(choices, i, &(&1 + 1)), rest, [dead_end | dead_ends])
      end
    end
  end
end
