defmodule PhoenixPhaser.PageController do
  use PhoenixPhaser.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
