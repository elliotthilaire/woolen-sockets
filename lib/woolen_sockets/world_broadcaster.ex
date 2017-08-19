defmodule WoolenSockets.WorldBroadcaster do

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_args) do
    world = WoolenSockets.GameState.get_world
    schedule_work()
    {:ok, world}
  end

  def handle_info(:work, existing_world) do
    new_world = WoolenSockets.GameState.get_world

    unless Map.equal?(existing_world, new_world) do
      IO.inspect(new_world)
      WoolenSocketsWeb.Endpoint.broadcast!("room:lobby", "update_world", new_world)
    end

    schedule_work()

    {:noreply, new_world}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 16)
  end
end
