defmodule FoodTruckApi.Repo do
  use Ecto.Repo,
    otp_app: :food_truck_api,
    adapter: Ecto.Adapters.Postgres
end
