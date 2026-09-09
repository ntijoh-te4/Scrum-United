defmodule FlowTest do

    ### Pizza order
    alias Pluggy.PizzaController
    alias Pluggy.OrderController

    def run(id, username) do
      ## Gå till databasen, ta ut pizza -> ta ut namn
      #name = pizza.get_name()
      #ingredients = pizza.get_ingredients()
        name = PizzaController.get_name(id)
        ingredients = PizzaController.get_ingredients(id)
        IO.puts(name)
        IO.inspect(ingredients)
        OrderController.new(username, name, ingredients)

    end
    #send(name, ingredients)
    ## Posta till backend, med [ingredienser, namn på person, namn på pizza]
    ### Skapa order baserad på [nya ingredienser, namn, namn på person]
    #sql.insert()
    ## Display order


end
