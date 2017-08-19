defmodule WoolenSocketsData.Velocity do

  alias WoolenSocketsData.Velocity

  defstruct [ x: 0, y: 0 ]

  @type t :: %Velocity{
    x: float,
    y: float
  }

end
