defmodule RPG.CharacterSheet do
  @aspects [:name, :class, :level]
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  @aspects |> Enum.each(fn aspect ->
    def unquote(:"ask_#{aspect}")() do
      IO.gets("What is your character's #{unquote(aspect)}?\n")
      |> String.trim()
      |> then(&(if unquote(aspect) == :level, do: String.to_integer(&1), else: &1))
    end
  end)

  def run() do
    welcome()
    character = for aspect <- @aspects, into: %{} do
        {aspect, apply(__MODULE__, :"ask_#{aspect}", [])}
    end
    IO.inspect(character, label: "Your character")
  end
end
