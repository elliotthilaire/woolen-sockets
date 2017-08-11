defmodule WoolenSockets.GameState do

  def start_link do
    initial_world = %World{}

    Agent.start_link(fn -> initial_world end, name: __MODULE__)
  end

  def add_player(player = %Player{}) do
    Agent.update(__MODULE__, fn world ->
      World.add_player(world, player)
    end)
  end

  def remove_player(player_id) do
    Agent.update(__MODULE__, fn world ->
      World.remove_player(world, player_id)
    end)
  end

  def update_player(player = %Player{}) do
    Agent.update(__MODULE__, fn world ->
      World.update_player(world, player)
    end)
  end

  def get_world do
    Agent.get(__MODULE__, &(&1))
  end

end
