defmodule Dominoes do
  import Bitwise, only: [bxor: 2, bor: 2, bsl: 2, band: 2, >>>: 2, &&&: 2]
  @type domino :: {1..6, 1..6}
  @cluster_mask 2 ** 6 - 1

  # choices:
  # presence of each domino type, as bit positions (shown reversed)
  # 112123123412345123456
  # x x  x   x    x     x
  # 012345678901234567890
  # follows OEIS A002260 (but zero-based)

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?(dominoes) do
    with {choices, parities} <- List.foldl(dominoes, {0, 0}, &triage_domino/2) do
      all_even_parities?(parities) and single_cluster?(choices)
    end
  end

  # mirror dominoes are not part of parity counting since their halves cancel each other out
  defp triage_domino({n, n}, {choices, parities}),
    do: {bor(choices, bsl(1, i(n, n))), parities}

  defp triage_domino({n1, n2}, {choices, parities}),
    do: {bor(choices, bsl(1, i(n1, n2))), bxor(parities, bor(bsl(1, n1), bsl(1, n2)))}

  defp i(n, n), do: div(n * (n + 1), 2) - 1
  defp i(n1, n2) when n2 > n1, do: i(n2, n1)
  defp i(n1, n2), do: i(n1 - 1, n1 - 1) + n2

  defp all_even_parities?(parities), do: parities == 0

  defp single_cluster?(choices) do
    final_clusters =
      Enum.reduce(0..20, 0, fn i, clusters ->
        if (choices >>> i &&& 1) == 0 do
          clusters
        else
          {n1, n2} = numbers_from_index(i)

          n1_shift = (n1 - 1) * 6
          n2_shift = (n2 - 1) * 6

          new_cluster =
            bor(
              mark_cluster_slot(clusters, n1_shift, n2),
              mark_cluster_slot(clusters, n2_shift, n1)
            )

          clusters
          |> bor(bsl(new_cluster, n1_shift))
          |> bor(bsl(new_cluster, n2_shift))
        end
      end)

    Enum.reduce(0..5, @cluster_mask, fn cluster_number, overlap ->
      final_cluster = final_clusters >>> (cluster_number * 6) &&& @cluster_mask

      if final_cluster == 0 do
        overlap
      else
        band(overlap, final_cluster)
      end
    end) != 0
  end

  defp numbers_from_index(i) when i < 1, do: {1, 1}
  defp numbers_from_index(i) when i < 3, do: {2, i}
  defp numbers_from_index(i) when i < 6, do: {3, i - 2}
  defp numbers_from_index(i) when i < 10, do: {4, i - 5}
  defp numbers_from_index(i) when i < 15, do: {5, i - 9}
  defp numbers_from_index(i) when i < 21, do: {6, i - 14}

  defp mark_cluster_slot(clusters, cluster, slot) do
    bor(
      clusters >>> cluster &&& @cluster_mask,
      bsl(1, slot - 1)
    )
  end
end
