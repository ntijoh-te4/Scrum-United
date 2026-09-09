defmodule Pluggy.PizzaController do
  alias Pluggy.Pizza
  def get_name(id), do: Pizza.get_name(id)
  def get_ingredients(id), do: Pizza.get_ingredients(id)
end
