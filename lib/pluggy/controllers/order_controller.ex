defmodule Pluggy.OrderController do
  alias Pluggy.Order
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def new(name, ingredients, group_id, is_ordered) do
    name = name |> List.flatten() |> hd()

    Postgrex.query!(DB, "INSERT INTO orders (order_name, group_id, date, is_ordered) VALUES ($1, $2, $3, $4)",
    [name, group_id, get_date(), is_ordered]) ### LÄGG GROUP HÄR

    id = Postgrex.query!(DB, "SELECT id FROM orders WHERE order_name = $1 LIMIT 1", [name]).rows
    |> List.flatten()
    |> hd()

    ingredients |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Order.add_ingredient(id, &1))
  end

def get_all_orders(conn), do: send_resp(conn, 200, render("pizzas/admin", groups: Enum.group_by(Order.all(), & &1.group)))



  def get_date do
    d = DateTime.now!("Etc/UTC")
    "#{d.year}-#{d.month}-#{d.day} #{d.hour+2}:#{d.minute}"
  end
end
