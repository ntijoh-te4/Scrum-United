defmodule Pluggy.CartController do
  alias Pluggy.CookieController
  alias Pluggy.OrderController
  alias Pluggy.PizzaController
  alias Pluggy.Ingredients
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
    {conn, user_id} = CookieController.get(conn)
    name = PizzaController.get_name(pizza_id)
    ingredients = PizzaController.get_ingredients(pizza_id)
    OrderController.new(name, ingredients, user_id, "pending")
    Redirect.redirect(conn, "/pizzas")
  end

  def new_custom(conn, pizza_id) do
    pizza_id = pizza_id |> String.to_integer()
    {conn, user_id} = CookieController.get(conn)
    parameters = conn.params
    ingredients_map = Map.delete(parameters, "pizza")
    name = PizzaController.get_name(pizza_id)
    inglist = Map.keys(ingredients_map)
    OrderController.new(name,inglist, user_id, "pending")
    Redirect.redirect(conn, "/pizzas")
  end

end
