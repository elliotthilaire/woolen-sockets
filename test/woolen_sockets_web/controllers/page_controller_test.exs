defmodule WoolenSocketsWeb.PageControllerTest do
  use WoolenSocketsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Being a sheep is more fun with friends."
  end
end
