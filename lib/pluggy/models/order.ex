defmodule Pluggy.Order do
  defstruct(id: nil, name: "", group: "", date: "", toppings: "")

  alias Pluggy.Order
  def add_ingredient(id, ingredient), do: Postgrex.query!(DB, "INSERT INTO order_rel (order_id, ingredient_id) VALUES ($1, $2)", [id, ingredient])

  def all() do
    Postgrex.query!(DB, "
                        SELECT orders.id, orders.order_name, orders.group_id, orders.date, array_agg(toppings.name)
                        FROM orders
                        JOIN order_rel
                        ON orders.id = order_rel.order_id
                        JOIN toppings
                        ON order_rel.ingredient_id = toppings.id
                        GROUP BY orders.id, orders.order_name
                        ").rows
    |> to_struct_list
  end


  def to_struct_list(rows) do
    for [id, name, group, date, toppings] <- rows, do: %Order{id: id, name: name, group: group, date: date, toppings: toppings}
  end
end
