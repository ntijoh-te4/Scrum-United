defmodule Pluggy.OrderController do
  alias Pluggy.Order
  alias Pluggy.Redirect
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def new(name, ingredients, group_id, order_status) do
    name = name |> List.flatten() |> hd()

    id = Order.new_get_id(name, group_id, order_status)

    ingredients |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Order.add_ingredient(id, &1))
  end

  def get_all_orders(conn), do: send_resp(conn, 200, render("pizzas/admin", groups: Enum.group_by(Order.all(), & &1.group)))

  def ready_order(conn, group) do

    order = "Ready for pick-up"

    Postgrex.query!(DB, "UPDATE orders SET is_ordered = $1 WHERE group_id = $2", [order, String.to_integer(group)])

    Redirect.redirect(conn, "/pizzas/admin")

  end

    def complete_order(conn, group) do

    order = "Delivered"

    Postgrex.query!(DB, "UPDATE orders SET is_ordered = $1 WHERE group_id = $2", [order, String.to_integer(group)])

    Redirect.redirect(conn, "/pizzas/admin")

  end

end
