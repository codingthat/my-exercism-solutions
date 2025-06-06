defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{opacity: opacity} = dot, frame_number, _)
    when rem(frame_number, 4) == 0, do: %DancingDots.Dot{dot | opacity: opacity / 2}

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def init(opts) do
    velocity = opts[:velocity]
    if is_number(velocity) do
      {:ok, opts}
    else
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{radius: radius} = dot, frame_number, [velocity: velocity]) do
    %DancingDots.Dot{dot | radius: radius + (frame_number - 1) * velocity}
  end
end
