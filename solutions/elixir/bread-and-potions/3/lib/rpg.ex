defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible, do: def eat(item, character)

  defimpl Edible, for: [LoafOfBread, ManaPotion, Poison] do
    def eat(%LoafOfBread{}, character = %Character{health: health}) do
      {nil, %Character{character | health: health + 5}}
    end
    def eat(%ManaPotion{strength: strength}, character = %Character{mana: mana}) do
      {%EmptyBottle{}, %Character{character | mana: mana + strength}}
    end
    def eat(%Poison{}, character = %Character{}) do
      {%EmptyBottle{}, %Character{character | health: 0}}
    end
  end
end
