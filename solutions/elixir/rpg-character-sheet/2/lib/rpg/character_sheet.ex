defmodule RPG.CharacterSheet do
  @aspects [:name, :class, :level]
  @aspects |> Enum.each(fn aspect ->
    def unquote(:"ask_#{aspect}")() do
      IO.gets("What is your character's #{unquote(aspect)}?\n")
      |> String.trim()
      |> then(&(if unquote(aspect) == :level, do: String.to_integer(&1), else: &1))
    end
  end)

  def welcome(), do: IO.puts("Welcome! Let's fill out your character sheet together.")

  def run() do
    welcome()
    for aspect <- @aspects, into: %{} do
        {aspect, apply(__MODULE__, :"ask_#{aspect}", [])}
    end |> IO.inspect(label: "Your character")
  end
end
