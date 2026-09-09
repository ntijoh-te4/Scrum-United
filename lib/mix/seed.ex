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
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS fruits", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas CASCADE", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS toppings CASCADE", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS groups", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizza_rel CASCADE", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS temp_rel CASCADE", [])
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [])
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "CREATE TABLE pizzas (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL, img TEXT NOT NULL)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE toppings (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE groups (id SERIAL PRIMARY KEY)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE orders (id SERIAL PRIMARY KEY, name VARCHAR(255) NOT NULL, order_name TEXT NOT NULL, group_id INTEGER NOT NULL, date TEXT NOT NULL)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE pizza_rel (pizza_id INTEGER REFERENCES pizza(id), topp_id INTEGER REFERENCES toppings(id))",
      []
    )
    Postgrex.query!(
      DB,
      "CREATE TABLE temp_rel (id SERIAL PRIMARY KEY)",
      []
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(255) NOT NULL UNIQUE, password_hash VARCHAR(60) NOT NULL)",
      []
    )

  end

  defp seed_data() do
    IO.puts("Seeding data")

    #pizzas
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Margherita", "margherita.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Marinara", "marinara.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Prosciutto e funghi", "prosciutto-e-funghi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Quattro stagioni", "quattro-stagioni.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Capricciosa", "capricciosa.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Quattro formaggi", "quattro-formaggi.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Ortolana", "ortolana.svg"])
    Postgrex.query!(DB, "INSERT INTO pizzas(name, img) VALUES($1, $2)", ["Diavola", "diavola.svg"])

    #toppings
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Tomatsås"]) #1
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Mozzarella"])#2
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Basilika"])#3
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Skinka"])#4
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Svamp"])#5
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Kronärtskocka"])#6
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Oliver"])#7
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Parmesan"])#8
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Pecorino"])#9
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Gorgonzola"])#10
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Paprika"])#11
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Aubergine"])#12
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Zucchini"])#13
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Salami"])#14
    Postgrex.query!(DB, "INSERT INTO toppings(name) VALUES($1)", ["Chili"])#15

    ## Margherita
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(1, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(1, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(1, 3)", [])
    # Marinara, [] VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(2, 1)", [])
    #Prosiutto e funghi, [] VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(3, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(3, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(3, 4)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(3, 5)", [])
    # Quattro, [] VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 4)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 5)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 6)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(4, 7)", [])
    # Capri, [] VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(5, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(5, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(5, 4)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(5, 5)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(5, 6)", [])
    # Quattro Formaggi VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(6, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(6, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(6, 8)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(6, 9)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(6, 15)", [])
    # Ortolana VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(7, 1)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(7, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(7, 11)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(7, 12)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(7, 13)", [])
    # Diavola VALUES
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(8, 1)",[])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(8, 2)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(8, 14)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(8, 11)", [])
    Postgrex.query!(DB, "INSERT INTO pizza_rel VALUES(8, 15)", [])

    #user
    Postgrex.query!(DB, "INSERT INTO users(username, password_hash) VALUES($1, $2)", ["a", Bcrypt.hash_pwd_salt("a")])

  end
end
