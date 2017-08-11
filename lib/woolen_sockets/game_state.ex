defmodule WoolenSockets.GameState do

  def start_link do
    initial_world = %World{}

    Agent.start_link(fn -> initial_world end, name: __MODULE__)
  end

  # WoolenSockets.GameState.add_player(%{player_id: 1})

  def add_player(%{player_id: player_id}) do
    Agent.update(__MODULE__, fn world ->
      World.add_player(world, %Player{id: player_id})
    end)
  end

  # WoolenSockets.GameState.remove_player(%{player_id: 1})

  def remove_player(%{player_id: player_id}) do
    Agent.update(__MODULE__, fn world ->
      World.remove_player(world, player_id)
    end)
  end

  # WoolenSockets.GameState.update_player(%{player_id: 1, position: %{x: 1, y: 2}})

  def update_player(%{player_id: player_id, position: position, velocity: velocity}) do
    Agent.update(__MODULE__, fn world ->
      World.update_player(world, %Player{id: player_id, position: position, velocity: velocity})
    end)
  end

  # WoolenSockets.GameState.get_world

  def get_world do
    Agent.get(__MODULE__, &(&1))
  end

end
