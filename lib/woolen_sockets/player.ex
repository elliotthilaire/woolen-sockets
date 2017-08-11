defmodule Player do

  @enforce_keys [ :id ]

  defstruct [ :id, position: %Position{}, velocity: %Velocity{} ]

  @type t :: %Player{
    id: integer,
    position: Position.t,
    velocity: Velocity.t
  }

end