defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", img: "")

  alias Pluggy.Pizza

  def all do
    Postgrex.query!(DB, "SELECT * FROM pizzas", []).rows
    |> to_struct_list

  end

  def get(id) do
    Postgrex.query!(DB, "SELECT * FROM pizzas WHERE id = $1 LIMIT 1", [String.to_integer(id)]).rows
    |> to_struct
  end

  @spec update(binary(), nil | maybe_improper_list() | map()) :: Postgrex.Result.t()
  def update(id, params) do
    name = params["name"]
    id = String.to_integer(id)

    Postgrex.query!(
      DB,
      "UPDATE pizzas SET name = $1 WHERE id = $2",
      [name, id]
    )
  end

  def create(params) do
    name = params["name"]

    Postgrex.query!(DB, "INSERT INTO pizzas (name) VALUES ($1)", [name])
  end

  def delete(id) do
    Postgrex.query!(DB, "DELETE FROM pizzas WHERE id = $1", [String.to_integer(id)])
  end

  def to_struct([[id, name, img]]) do
    %Pizza{id: id, name: name, img: img}
  end

  def to_struct_list(rows) do
    for [id, name, img] <- rows, do: %Pizza{id: id, name: name, img: img}
  end











  def get_name(id) do
    Postgrex.query!(DB, "SELECT name FROM pizzas WHERE id = $1 LIMIT 1", [id]).rows
  end
  def get_ingredients(id) do
    Postgrex.query!(DB, "SELECT topp_id::text FROM pizza_rel WHERE pizza_id = $1", [id]).rows |> List.flatten()
  end
end
