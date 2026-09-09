defmodule FlowTest do

    ### Pizza order
    alias Pluggy.PizzaController

    def run(id) do
        name = PizzaController.get_name(id)
        ingredients = PizzaController.get_ingredients(id)
        IO.puts(name, ingredients)
    end

  ## Gå till databasen, ta ut pizza -> ta ut namn
  #name = pizza.get_name()
  #ingredients = pizza.get_ingredients()
  ## => [x,x,x,x]

  #send(name, ingredients)
  ## Posta till backend, med [ingredienser, namn på person, namn på pizza]
  ### Skapa order baserad på [nya ingredienser, namn, namn på person]
  #sql.insert()
  ## Display order


end
