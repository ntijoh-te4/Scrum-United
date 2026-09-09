defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run("app.start")
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS toppings", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS group", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza_rel", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS temp_rel", [])
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "CREATE TABLE pizza (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL), img TEXT NOT NULL)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE toppings (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE group (id SERIAL PRIMARY KEY)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE orders (id SERIAL PRIMARY KEY, name NOT NULL, order_name NOT NULL, group_id NOT NULL, date TEXT NOT NULL)",
      []
    )

        Postgrex.query!(
      DB,
      "CREATE TABLE pizza_rel (pizza_id INTEGER REFRENCES pizza(id), topp_id INTEGER REFRENCES toppings(id))",
      []
    )
        Postgrex.query!(
      DB,
      "CREATE TABLE temp_rel (id)",
      []
    )

  end

  defp seed_data() do
    IO.puts("Seeding data")

    #pizzas
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Margherita", "margherita.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Marinara", "marinara.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Prosciutto e funghi", "prosciutto-e-funghi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Quattro stagioni", "quattro-stagioni.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Capricciosa", "capricciosa.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Quattro formaggi", "quattro-formaggi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Ortolana", "ortolana.svg"])
    Postgrex.query!(DB, "INSERT INTO pizza(name, img) VALUES($1, $2)", ["Diavola", "diavola.svg"])

    #toppings
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Tomatsås"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Mozzarella"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Basilika"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Skinka"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Svamp"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Kronärtskocka"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Oliver"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Parmesan"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Pecorino"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Gorgonzola"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Paprika"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Aubergine"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Zucchini"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Salami"])
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Chili"])


    Postgrex.query!(DB, "INSERT INTO pizza_rel(pizza_id, topp_id)")

  end
end
