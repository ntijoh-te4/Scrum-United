defmodule Pluggy.CartController do
  alias Pluggy.CookieController
  alias Pluggy.OrderController
  alias Pluggy.PizzaController
  alias Pluggy.Redirect
  import Pluggy.Template, only: [render: 1]
  import Plug.Conn, only: [send_resp: 3]

  def show(conn) do
    # IO.inspect(conn)
    # {conn, _id} = CookieController.get(conn)
    send_resp(conn, 200, render("cart/page"))
  end

  def new(conn, pizza_id) do

    pizza_id = pizza_id |> String.to_integer()

    IO.inspect(conn)
    {conn, user_id} = CookieController.get(conn)
    #IO.inspect(user_id)
    IO.inspect(conn)

    name = PizzaController.get_name(pizza_id)
    ingredients = PizzaController.get_ingredients(pizza_id)

    OrderController.new(name, ingredients, user_id, "pending")
    Redirect.redirect(conn, "/pizzas")

  end

end
