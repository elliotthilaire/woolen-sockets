defmodule WoolenSockets.WorldTransformer do

  alias WoolenSockets.{World, Player}

  @spec add_player(World.t, Player.t) :: World.t
  def add_player(world, player) do
    players = world.players
    players = Map.put_new(players, player.id, player)

    %World{players: players}
  end

  @spec remove_player(World.t, String.t) :: World.t
  def remove_player(world, player_id) do
    players = world.players
    players = Map.delete(players, player_id)

    %World{players: players}
  end

  @spec update_player(World.t, Player.t) :: World.t
  def update_player(world, player) do
    players = world.players
    players = Map.put(players, player.id, player)

    %World{players: players}
  end

end
