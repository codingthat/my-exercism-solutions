defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score), do: score - 10 |> Integer.floor_div(2)

  @spec ability :: pos_integer()
  def ability, do: 1..6
    |> Enum.take_random(4)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()

  @spec character :: t()
  def character do
    abilities = struct(__MODULE__,
      for(key <- Map.keys(__MODULE__.__struct__()) -- [:hitpoints], do:
        {key, ability()}
      )
    )
    %{abilities | hitpoints: 10 + modifier(abilities.constitution)}
  end
end
