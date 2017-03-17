defmodule PhoenixPhaser.WorldBroadcaster do

  def start_link do
    world = PhoenixPhaser.GameState.get
    broadcast_world(world)
  end

  def broadcast_world(world) do
    new_world = PhoenixPhaser.GameState.get

    unless Map.equal?(world, new_world) do
      IO.inspect(new_world)
      PhoenixPhaser.Endpoint.broadcast!("room:lobby", "update_world", new_world)
    end

    Process.sleep(16)
    broadcast_world(new_world)
  end

end
