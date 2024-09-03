defmodule FoodTruckApiWeb.Router do
  use FoodTruckApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FoodTruckApiWeb do
    pipe_through :api
  end
end
