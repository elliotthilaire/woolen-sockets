defmodule WoolenSocketsData.Position do

  alias WoolenSocketsData.Position

  defstruct [ :x, :y ]

  @type t :: %Position{
    x: float,
    y: float
  }

end
