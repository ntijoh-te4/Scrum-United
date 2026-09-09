 defmodule Pluggy.IndexController do
     import Plug.Conn, only: [send_resp: 3]
     import Pluggy.Template, only: [render: 1]
   def index(conn), do: send_resp(conn, 200, render("index"))
 end
