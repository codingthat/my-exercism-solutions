defmodule LibraryFees do
  import NaiveDateTime, only: [to_date: 1, from_iso8601!: 1]

  def calculate_late_fee(checkout, return, rate),
    do:
      return
      |> datetime_from_string()
      |> then(fn actual_return_datetime ->
          checkout
          |> datetime_from_string()
          |> return_date()
          |> days_late(actual_return_datetime)
          |> Kernel.*(if(monday?(actual_return_datetime),
                        do: rate / 2,
                        else: rate))
          |> trunc()
      end)

  def datetime_from_string(string), do: from_iso8601!(string)

  def before_noon?(%{hour: hour}), do: hour < 12

  def return_date(checkout_datetime),
    do:
      checkout_datetime
      |> to_date()
      |> Date.add(if(before_noon?(checkout_datetime),
                    do: 28,
                    else: 29))

  def days_late(planned_return_date, actual_actual_return_datetime),
    do:
      actual_actual_return_datetime
      |> to_date()
      |> Date.diff(planned_return_date)
      |> max(0)

  def monday?(datetime), do: Date.day_of_week(to_date(datetime)) == 1
end
