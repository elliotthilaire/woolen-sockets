defmodule PhoenixPhaser.GameState do

  def start_link do
    initial_world = %{ players: %{} }

    Agent.start_link(fn -> initial_world end, name: __MODULE__)
  end

  # PhoenixPhaser.GameState.add_player(%{player_id: 1})

  def add_player(%{player_id: player_id}) do
    Agent.update(__MODULE__, fn world ->
      put_in(world, [:players, to_string(player_id)], %{position: %{}})
    end)
  end

  # PhoenixPhaser.GameState.update_player(%{player_id: 1, position: %{x: 1, y: 2}})

  def update_player(%{player_id: player_id, position: position}) do
    Agent.update(__MODULE__, fn world ->
      put_in(world, [:players, to_string(player_id), :position], position)
    end)
  end

  # PhoenixPhaser.GameState.get_world

  def get_world do
    Agent.get(__MODULE__, &(&1))
  end

end
