defmodule PhoenixPhaser.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_position", %{"player" => player, "position" => %{"x" => x, "y" => y}}, socket) do
    PhoenixPhaser.GameState.put(player, %{x: x, y: y})

    {:noreply, socket}
  end

  def handle_in("im_new_here", %{"player" => player, "position" => %{"x" => x, "y" => y}}, socket) do
    PhoenixPhaser.GameState.put(player, %{x: x, y: y})

    new_player = %{player_id: player, position: %{x: x, y: y}}
    world = PhoenixPhaser.GameState.get
    IO.inspect(new_player)

    broadcast! socket, "new_player_joined", new_player
    broadcast! socket, "hello_world", world
    {:noreply, socket}
  end

end
