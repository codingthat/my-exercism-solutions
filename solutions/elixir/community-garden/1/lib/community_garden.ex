# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{next_id: 1, plots: []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{next_id: next_id, plots: plots} = state ->
      new_plot = %Plot{plot_id: next_id, registered_to: register_to}

      new_state = %{
        state
        | next_id: next_id + 1,
          plots: List.insert_at(plots, -1, new_plot)
      }

      {new_plot, new_state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{next_id: _next_id, plots: plots} = state ->
      %{
        state
        | plots: List.delete_at(plots, Enum.find_index(plots, fn plot -> plot.plot_id == plot_id end))
      }
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{next_id: _next_id, plots: plots} -> plots end)
    |> Enum.find({:not_found, "plot is unregistered"}, fn plot -> plot.plot_id == plot_id end)
  end
end
