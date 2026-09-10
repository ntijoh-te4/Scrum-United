defmodule Pluggy.Order do
  def add_ingredient(id, ingredient), do: Postgrex.query!(DB, "INSERT INTO temp_rel (order_id, ingredient_id) VALUES ($1, $2)", [id, ingredient])
end
