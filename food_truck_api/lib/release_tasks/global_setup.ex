defmodule ReleaseTasks.GlobalSetup do
  alias FoodTruckApi.CsvUtil
    alias FoodTruckApi.Trucks
    alias FoodTruckApi.Locations
    alias FoodTruckApi.MenuItems
  """
  Module to seed the database with data
  """
  use Mix.Task

  def run do


    FoodTruckApi.Repo.delete_all(Locations.Location)
    FoodTruckApi.Repo.delete_all(MenuItems.MenuItem)
    FoodTruckApi.Repo.delete_all(Trucks.Truck)
    :code.priv_dir(:food_truck_api)
    |>Path.join("repo/data/Mobile_Food_Facility_Permit.csv")
    |> CsvUtil.load_food_truck_data_from_csv()
    |> Enum.to_list()
    |> Enum.map(fn truck_info ->
      Ecto.Multi.new()
      |> Ecto.Multi.run(:truck, fn _repo, _changes -> Trucks.create_truck(truck_info) end)
      |> Ecto.Multi.run(:location, fn _repo, %{truck: truck} ->
        Locations.create_location(
          Map.merge(truck_info.location_info, %{status: "active", truck_id: truck.id})
        )
      end)
      |> Ecto.Multi.run(:menu_items, fn _repo, %{truck: truck} ->
        items =
          Enum.map(truck_info.menu_items, fn menu_item ->
            MenuItems.create_menu_item(%{item_name: menu_item, truck_id: truck.id})
          end)

        {:ok, items}
      end)
      |> FoodTruckApi.Repo.transaction()
    end)
  end
end
