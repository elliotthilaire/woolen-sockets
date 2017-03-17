defmodule PhoenixPhaser.GameState do

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def put(player, position = %{x: _x, y: _y}) do
    Agent.update(__MODULE__, &Map.put(&1, player, position))
  end

  def get do
    Agent.get(__MODULE__, &(&1))
  end
end
