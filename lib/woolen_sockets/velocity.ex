defmodule WoolenSockets.Velocity do

  alias WoolenSockets.Velocity

  defstruct [ x: 0, y: 0 ]

  @type t :: %Velocity{
    x: float,
    y: float
  }

end
