defmodule Velocity do

  defstruct [ x: 0, y: 0 ]

  @type t :: %Velocity{
    x: float,
    y: float
  }

end
