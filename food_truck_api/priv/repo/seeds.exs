# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTruckApi.Repo.insert!(%FoodTruckApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FoodTruckApi.CsvUtil
alias FoodTruckApi.Trucks
alias FoodTruckApi.Locations
alias FoodTruckApi.MenuItems

FoodTruckApi.Repo.delete_all(Locations.Location)
FoodTruckApi.Repo.delete_all(MenuItems.MenuItem)
FoodTruckApi.Repo.delete_all(Trucks.Truck)

"priv/repo/data/Mobile_Food_Facility_Permit.csv"
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
