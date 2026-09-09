defmodule Pluggy.Pizza do

  def get_name(id) do
    Postgrex.query!(DB, "SELECT name FROM pizza WHERE id = $1 LIMIT 1", [id]).rows
  end
  def get_ingredients(id) do
    Postgrex.query!(DB, "SELECT * FROM pizza_rel WHERE pizza_id = $1 LIMIT 1", [id]).rows
  end
end
