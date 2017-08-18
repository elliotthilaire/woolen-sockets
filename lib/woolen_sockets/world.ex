defmodule World do

  defstruct [ players: %{} ]

  @type t :: %World{
    players: map
  }

end
