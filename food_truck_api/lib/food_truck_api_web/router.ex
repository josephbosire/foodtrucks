defmodule FoodTruckApiWeb.Router do
  use FoodTruckApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Corsica, origins: "*"
  end

  scope "/api", FoodTruckApiWeb do
    pipe_through :api

    resources "/trucks", TruckController do
      resources "/locations", LocationController
      resources "/menu_items", MenuItemController
    end
  end
end
