defmodule WoolenSockets.World do

  alias WoolenSockets.World

  defstruct [ players: %{} ]

  @type t :: %World{
    players: map
  }

end
