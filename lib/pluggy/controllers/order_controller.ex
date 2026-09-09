defmodule Pluggy.OrderController do
  def new(_username, _name, ingredients) do
    ## Temp key
    ## Get ingredients
    #id = Postgrex.query!(DB, "INSERT INTO groups DEFAULT VALUES RETURNING id", []).rows
    ## Create order
    #order_id = Postgrex.query!(DB, "INSERT INTO orders VALUES ($1, $2) RETURNING id", [username, name, id, "N/A"]).rows
    ## Add ingredients to
    ingredients = ingredients |> Enum.map(&String.to_integer/1)
    IO.inspect(ingredients)
  end
end
