defmodule FoodTruckApi.MenusFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckApi.Menus` context.
  """

  @doc """
  Generate a menu.
  """
  def menu_fixture(attrs \\ %{}) do
    {:ok, menu} =
      attrs
      |> Enum.into(%{
        item_name: "some item_name"
      })
      |> FoodTruckApi.Menus.create_menu()

    menu
  end
end
