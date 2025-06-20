defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg), do: GenServer.start_link(__MODULE__, init_arg)

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue_new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  # Server callbacks

  @impl GenServer
  def init(init_arg) do
    if init_arg[:auto_shutdown_timeout] do
      TakeANumberDeluxe.State.new(init_arg[:min_number], init_arg[:max_number], init_arg[:auto_shutdown_timeout])
    else
      TakeANumberDeluxe.State.new(init_arg[:min_number], init_arg[:max_number])
    end |> append_timeout()
  end

  @impl GenServer
  def handle_call(:report_state, _, state), do: {:reply, state, state} |> append_timeout()

  @impl GenServer
  def handle_call(:queue_new_number, _, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} -> {:reply, {:ok, new_number}, new_state}
      {:error, _} = e -> {:reply, e, state}
    end |> append_timeout()
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} -> {:reply, {:ok, next_number}, new_state}
      {:error, _} = e -> {:reply, e, state}
    end |> append_timeout()
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {
      :noreply,
      TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
      |> elem(1)
    } |> append_timeout()
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}
  @impl GenServer
  def handle_info(_, state), do: {:noreply, state} |> append_timeout()

  defp append_timeout({:error, :invalid_configuration} = msg), do: msg
  defp append_timeout({msg, state}), do: {msg, state, state.auto_shutdown_timeout}
  defp append_timeout({msg, reply, state}), do: {msg, reply, state, state.auto_shutdown_timeout}

end
