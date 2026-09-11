defmodule Pluggy.CookieController do

  alias Pluggy.Cookie

  def get(conn) when conn.cookies == %{} do
    cookie = generate()
    %{conn | cookies: %{"pizza_cookie" => cookie}, resp_headers: [{"Set-Cookie", "pizza_cookie=#{cookie}"}]}
    |> get
  end

  def get(conn) do
    cookie = retrieve_cookie(conn)
    id = Cookie.get_session_id(cookie)
    |> get_or_create(conn)
    {conn, id}
  end

  def retrieve_cookie(conn), do: conn.cookies["pizza_cookie"]

  def get_or_create([], conn) do
    cookie = retrieve_cookie(conn)
    Cookie.save_cookie(cookie)
    {_conn, id} = get(conn)
    id
  end
  def get_or_create([[id]], _conn), do: id

  def generate(), do: (for _ <- 1..25, into: "", do: <<Enum.random(~c"0123456789abcdef")>>)
end
