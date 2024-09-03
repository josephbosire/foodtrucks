defmodule FoodTruckApi.MenuItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckApi.MenuItems` context.
  """

  @doc """
  Generate a menu_item.
  """
  def menu_item_fixture(attrs \\ %{}) do
    truck = FoodTruckApi.TrucksFixtures.truck_fixture()

    {:ok, menu_item} =
      attrs
      |> Enum.into(%{
        item_name: "some item_name",
        truck_id: truck.id
      })
      |> FoodTruckApi.MenuItems.create_menu_item()

    menu_item
  end
end
