defmodule Pluggy.Ingredients do
  def get(), do: Postgrex.query!(DB, "SELECT id, name FROM toppings", []).rows

  def get_ingredient_from_key(key), do: Postgrex.query!(DB, "SELECT id FROM toppings WHERE name = $1", [key])

end
