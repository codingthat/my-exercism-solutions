defmodule TakeANumber do
  defp machine(state \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        machine(state)
      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        machine(new_state)
      :stop -> nil
      _ -> machine(state)
    end
  end
  def start() do
    spawn(fn -> machine() end)
  end
end
