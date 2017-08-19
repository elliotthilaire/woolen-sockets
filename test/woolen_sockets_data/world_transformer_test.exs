defmodule WoolenSockets.WorldTransformerTest do
  use ExUnit.Case, async: true
  alias WoolenSocketsData.{World, Player, Position}

  describe "add_player/2" do
    setup do
      %{world: %World{}, player: %Player{id: 1}}
    end

    test "adds a player", %{world: world, player: player} do
      world = WoolenSocketsData.WorldTransformer.add_player(world, player)
      assert world == %World{players: %{player.id => player}}
    end
  end

  describe "update_player/2" do
    setup do
      world = %World{players: %{1 => %Player{id: 1, position: %Position{x: 1, y: 1}}}}
      player = %Player{id: 1, position: %Position{x: 2, y: 2}}
      %{world: world, player: player}
    end

    test "updates a player", %{world: world, player: player} do
      world = WoolenSocketsData.WorldTransformer.update_player(world, player)
      assert world == %World{players: %{player.id => player}}
    end
  end

  describe "remove_player/2" do
    setup do
      player = %Player{id: 1}
      world = %World{players: %{player.id => player}}

      %{world: world, player: player}
    end

    test "removes a player", %{world: world, player: player} do
      world = WoolenSocketsData.WorldTransformer.remove_player(world, player.id)
      assert world == %World{players: %{}}
    end

  end
end
