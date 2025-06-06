defmodule RPG.CharacterSheet do
  @aspects [:name, :class, :level]
  @aspects |> Enum.each(fn aspect ->
    body = quote do IO.gets("What is your character's #{unquote(aspect)}?\n") |> String.trim() end
    body = if(aspect == :level, do: quote do unquote(body) |> String.to_integer() end, else: body)
    def unquote(:"ask_#{aspect}")(), do: unquote(body)
  end)

  def welcome(), do: IO.puts("Welcome! Let's fill out your character sheet together.")

  def run() do
    welcome()
    for aspect <- @aspects, into: %{} do
        {aspect, apply(__MODULE__, :"ask_#{aspect}", [])}
    end |> IO.inspect(label: "Your character")
  end
end
