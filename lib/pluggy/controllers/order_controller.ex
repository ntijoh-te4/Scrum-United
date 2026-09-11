defmodule Pluggy.OrderController do
  alias Pluggy.Order
  def new(name, ingredients, group_id, is_ordered) do
    name = name |> List.flatten() |> hd()

    Postgrex.query!(DB, "INSERT INTO orders (order_name, group_id, date, is_ordered) VALUES ($1, $2, $3, $4)",
    [name, group_id, get_date(), is_ordered]) ### LÄGG GROUP HÄR

    id = Postgrex.query!(DB, "SELECT id FROM orders WHERE order_name = $1 LIMIT 1", [name]).rows
    |> List.flatten()
    |> hd()

    ingredients |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Order.add_ingredient(id, &1))


    IO.inspect(id)
  end

  def get_date do
    d = DateTime.now!("Etc/UTC")
    "#{d.year}-#{d.month}-#{d.day} #{d.hour+2}:#{d.minute}"
  end
end
