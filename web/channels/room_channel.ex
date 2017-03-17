defmodule PhoenixPhaser.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def handle_in("new_position", %{"player" => player, "position" => %{"x" => x, "y" => y}}, socket) do
    PhoenixPhaser.GameState.put(player, %{x: x, y: y})

    # broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end
end
