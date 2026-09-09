defmodule Pluggy.PizzaController do
  alias Pluggy.Pizza
  alias Pluggy.User
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def index(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
          _ -> User.get(session_user)
      end

    send_resp(conn, 200, render("pizzas/index", pizzas: Pizza.all(), user: current_user))
  end

  # render använder eex
  def new(conn), do: send_resp(conn, 200, render("pizzas/new", []))
  def show(conn, id), do: send_resp(conn, 200, render("pizzas/show", pizza: Pizza.get(id)))
  def edit(conn, id), do: send_resp(conn, 200, render("pizzas/edit", pizza: Pizza.get(id)))

  def create(conn, params) do
    Pizza.create(params)

    case params["file"] do
      # do nothing
      nil ->
        IO.puts("No file uploaded")

      # copy uploaded file out of the tmp-folder (Plug deletes the tmp file after the request)
      %Plug.Upload{path: path, filename: filename} ->
        # Path.basename strips any directory part the client may have sent (../../ etc)
        File.cp!(path, "priv/static/uploads/#{Path.basename(filename)}")
    end

    redirect(conn, "/pizzas")
  end

  def update(conn, id, params) do
    Pizza.update(id, params)
    redirect(conn, "/pizzas")
  end

  def destroy(conn, id) do
    Pizza.delete(id)
    redirect(conn, "/pizzas")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end





  def get_name(id), do: Pizza.get_name(id)
  def get_ingredients(id), do: Pizza.get_ingredients(id)
end
