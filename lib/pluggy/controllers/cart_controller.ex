defmodule Pluggy.CartController do
  # alias Pluggy.CookieController
  import Pluggy.Template, only: [render: 1]
  import Plug.Conn, only: [send_resp: 3]

  def show(conn) do
    # IO.inspect(conn)
    # {conn, _id} = CookieController.get(conn)
    send_resp(conn, 200, render("cart/page"))
  end
end
