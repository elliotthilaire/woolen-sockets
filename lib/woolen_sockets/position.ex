defmodule WoolenSockets.Position do

  alias WoolenSockets.Position

  defstruct [ :x, :y ]

  @type t :: %Position{
    x: float,
    y: float
  }

end
