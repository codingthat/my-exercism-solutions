defmodule HighSchoolSweetheart do
  def first_letter(name), do: name |> String.trim |> String.first
  def initial(name), do: String.upcase(first_letter(name)) <> "."
  def initials(full_name), do: full_name |> String.split() |> Enum.map_join(" ", &initial/1)

  def pair(full_name1, full_name2) do
    [i1, i2] = Enum.map([full_name1, full_name2], &initials/1)
    """
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     #{i1}  +  #{i2}     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"""
  end
end
