defmodule WoolenSocketsData.Player do

  alias WoolenSocketsData.{Player, Position, Velocity}

  @enforce_keys [ :id ]

  defstruct [ :id, position: %Position{}, velocity: %Velocity{} ]

  @type t :: %Player{
    id: integer,
    position: Position.t,
    velocity: Velocity.t
  }

end
