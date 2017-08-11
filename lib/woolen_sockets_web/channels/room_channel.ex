defmodule WoolenSocketsWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_position", %{"player_id" => player_id, "position" => %{"x" => px, "y" => py}, "velocity" => %{"x" => vx, "y" => vy}}, socket) do
    WoolenSockets.GameState.update_player(%{player_id: player_id, position: %{x: px, y: py}, velocity: %{x: vx, y: vy}})

    {:noreply, socket}
  end

  def handle_in("im_new_here",  %{"player_id" => player_id, "position" => %{"x" => px, "y" => py}, "velocity" => %{"x" => vx, "y" => vy}}, socket) do
    WoolenSockets.GameState.add_player(%{player_id: player_id})
    WoolenSockets.GameState.update_player(%{player_id: player_id, position: %{x: px, y: py}, velocity: %{x: vx, y: vy}})

    new_player = %{player_id: player_id, position: %{x: px, y: py}, velocity: %{x: vx, y: vy}}
    broadcast_from socket, "new_player_joined", new_player

    world = WoolenSockets.GameState.get_world
    push socket, "hello_world", world

    socket = assign(socket, :player_id, player_id)

    {:noreply, socket}
  end

  def terminate(_reason, socket) do
    player_id = socket.assigns[:player_id]

    WoolenSockets.GameState.remove_player(%{player_id: player_id})
    broadcast_from socket, "player_left", %{player_id: player_id}

    {:noreply, socket}
  end
end
