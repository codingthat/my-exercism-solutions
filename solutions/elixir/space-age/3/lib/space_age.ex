defmodule SpaceAge do
  @period %{
    :mercury => 0.2408467,
    :venus => 0.61519726,
    :earth => 1.0,
    :mars => 1.8808158,
    :jupiter => 11.862615,
    :saturn => 29.447498,
    :uranus => 84.016846,
    :neptune => 164.79132,
  }
  @quoted_planets @period
    |> Enum.map_join(" | ", &(":" <> Atom.to_string(elem(&1, 0))))
    |> Code.string_to_quoted!()
  @type planet :: unquote(@quoted_planets)

@doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  for {planet, period} <- @period do
    def age_on(unquote(planet), seconds), do: {:ok, seconds / 31_557_600 / unquote(period)}
  end
  def age_on(_, _), do: {:error, "not a planet"}
end
