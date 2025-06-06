defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{distance_driven_in_meters: m}) do
    "#{m} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: bp}) do
    "Battery #{if(bp > 0, do: "at #{bp}%", else: "empty")}"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: remote_car
  def drive(%RemoteControlCar{battery_percentage: bp, distance_driven_in_meters: m} = remote_car) do
    %{remote_car | battery_percentage: bp - 1, distance_driven_in_meters: m + 20}
  end
end
