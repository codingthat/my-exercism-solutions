defmodule Garden do
  @plant_map %{
    ?C => :clover,
    ?G => :grass,
    ?R => :radishes,
    ?V => :violets,
  }
  @student_names_default [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry,
  ]
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ []) do
    student_names = if(student_names == [],
      do: @student_names_default,
      else: Enum.sort(student_names)
    )
    info(info_string, student_names, Map.new(student_names, &({&1, {}})), 0)
  end


  defp info("", _, acc, _), do: acc
  defp info(<<?\n, info_string::binary>>, student_names, acc, _), do:
    info(info_string, student_names, acc, 0)
  defp info(<<a::utf8, b::utf8, info_string::binary>>, student_names, acc, n) do
    student = Enum.at(student_names, n)
    cur_plants = acc[student]
    new_plants = if(cur_plants == {},
      do:                                             {@plant_map[a], @plant_map[b]},
      else: {elem(cur_plants, 0), elem(cur_plants, 1), @plant_map[a], @plant_map[b]}
    )
    info(info_string, student_names, Map.put(acc, student, new_plants), n + 1)
  end
end
