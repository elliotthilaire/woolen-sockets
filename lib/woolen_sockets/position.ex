defmodule Position do

  defstruct [ :x, :y ]

  @type t :: %Position{
    x: float,
    y: float
  }

end
