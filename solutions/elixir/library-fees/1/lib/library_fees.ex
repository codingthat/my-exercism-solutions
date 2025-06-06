defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00])
    == :lt
  end

  def return_date(checkout_datetime) do
    days = if(before_noon?(checkout_datetime), do: 28, else: 29)
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  def days_late(planned_return_date, actual_actual_return_datetime) do
    actual_actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    actual_return_datetime = datetime_from_string(return)
    (
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(actual_return_datetime)
    ) * if(monday?(actual_return_datetime), do: rate / 2, else: rate)
    |> trunc()
  end
end
