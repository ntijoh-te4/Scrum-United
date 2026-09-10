defmodule Pluggy.CookieController do

  def get(conn) when conn.cookies == %{} do
    cookie = generate()
    %{conn | cookies: %{"pizza_cookie" => cookie}, resp_headers: [{"Set-Cookie", "pizza_cookie=#{cookie}"}]}
    |> get
  end

  def get(conn) do
    session = retrieve_cookie(conn)
    id = Postgrex.query!(DB, "SELECT id FROM sessions WHERE session = $1", [session]).rows
    |> smth(conn)
    {conn, id}
  end

  def retrieve_cookie(conn), do: conn.cookies["pizza_cookie"]

  def smth([], conn) do
    session = retrieve_cookie(conn)
    Postgrex.query!(DB, "INSERT INTO sessions (session) VALUES ($1)", [session])
    get(conn)
  end

  def smth([[id]], _conn), do: id

  def generate(), do: (for _ <- 1..25, into: "", do: <<Enum.random(~c"0123456789abcdef")>>)
end
