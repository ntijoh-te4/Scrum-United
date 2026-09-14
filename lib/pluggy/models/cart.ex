defmodule Pluggy.Cart do

  def get_cart(id) do
    query = """
    SELECT orders.id, orders.order_name, array_agg(toppings.name)
    FROM orders
    JOIN order_rel
    ON orders.id = order_rel.order_id
    JOIN toppings
    ON order_rel.ingredient_id = toppings.id
    WHERE orders.group_id = $1
    AND orders.is_ordered = 'pending'
    GROUP BY orders.id, orders.order_name
    """

    transform = fn [order, pizza, toppings] -> %{order: order, pizza: pizza, toppings: toppings} end

    Postgrex.query!(DB, query, [id]).rows
    |> Enum.map(transform)
  end
end
