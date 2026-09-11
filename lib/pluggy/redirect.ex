defmodule Pluggy.Redirect do
  import Plug.Conn, only: [send_resp: 3]

  def redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
