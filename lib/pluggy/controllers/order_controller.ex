defmodule Pluggy.OrderController do
  alias Pluggy.Order
  def new(username, name, ingredients) do
    name = name |> List.flatten() |> hd()

    Postgrex.query!(DB, "INSERT INTO orders (name, order_name, group_id, date) VALUES ($1, $2, $3, $4)",
    [username, name, 1, "today"])

    id = Postgrex.query!(DB, "SELECT id FROM orders WHERE name = $1 LIMIT 1", [username]).rows
    |> List.flatten()
    |> hd()

    ingredients |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Order.add_ingredient(id, &1))


    IO.inspect(id)
  end
end
