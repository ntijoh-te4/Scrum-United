defmodule Pluggy.AdminController do
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def show(conn), do: send_resp(conn, 200, render("/pizzas/admin", []))
end
