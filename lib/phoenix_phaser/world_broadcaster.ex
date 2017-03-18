defmodule PhoenixPhaser.WorldBroadcaster do
  use GenServer

  # 16 milliseconds is (60fps)
  @delay_time 16

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(_state) do
    world = PhoenixPhaser.GameState.get

    Process.send_after(self(), :work, @delay_time)
    {:ok, world}
  end

  def handle_info(:work, existing_world) do
    new_world = PhoenixPhaser.GameState.get

    unless Map.equal?(existing_world, new_world) do
      IO.inspect(new_world)
      PhoenixPhaser.Endpoint.broadcast!("room:lobby", "update_world", new_world)
    end

    # Start the timer again
    Process.send_after(self(), :work, @delay_time)

    {:noreply, new_world}
  end
end
