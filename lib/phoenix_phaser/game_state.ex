defmodule PhoenixPhaser.GameState do

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def put(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
  end

  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def get do
    Agent.get(__MODULE__, &(&1))
  end

end
