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

    broadcast_from socket, "update_world", %{ x: x, y: y}
    {:noreply, socket}
  end

  def handle_in("new_player", %{"player" => player, "position" => %{"x" => x, "y" => y}}, socket) do
    PhoenixPhaser.GameState.put(player, %{x: x, y: y})
    new_player = %{player_id: player, position: %{x: x, y: y}}
    IO.inspect(new_player)

    broadcast_from socket, "new_player", new_player
    {:noreply, socket}
  end

end
