defmodule WoolenSocketsWeb.PageController do
  use WoolenSocketsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
