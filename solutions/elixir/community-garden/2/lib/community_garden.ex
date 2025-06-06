# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {1, %{}} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_next_id, plots} ->
      Enum.map(plots, fn {plot_id, registered_to} ->
        %Plot{plot_id: plot_id, registered_to: registered_to}
      end)
    end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {next_id, plots} -> {
      %Plot{plot_id: next_id, registered_to: register_to},
      {next_id + 1, Map.put(plots, next_id, register_to)}
    } end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {next_id, plots} -> {
      next_id, Map.delete(plots, plot_id)
    } end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {_next_id, plots} ->
      registered_to = plots[plot_id]
      if registered_to do
        %Plot{plot_id: plot_id, registered_to: registered_to}
      else
        {:not_found, "plot is unregistered"}
      end
    end)
  end
end
