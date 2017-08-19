defmodule WoolenSocketsData.World do

  alias WoolenSocketsData.World

  defstruct [ players: %{} ]

  @type t :: %World{
    players: map
  }

end
