defmodule FoodTruckApi.MenuItemsTest do
  use FoodTruckApi.DataCase

  alias FoodTruckApi.MenuItems

  describe "menu_items" do
    alias FoodTruckApi.MenuItems.MenuItem

    import FoodTruckApi.MenuItemsFixtures

    @invalid_attrs %{item_name: nil}

    setup do
      truck = FoodTruckApi.TrucksFixtures.truck_fixture()
      {:ok, truck: truck}
    end

    test "list_menu_items/0 returns all menu_items" do
      menu_item = menu_item_fixture()
      assert MenuItems.list_menu_items() == [menu_item]
    end

    test "get_menu_item!/1 returns the menu_item with given id" do
      menu_item = menu_item_fixture()
      assert MenuItems.get_menu_item!(menu_item.id) == menu_item
    end

    test "create_menu_item/1 with valid data creates a menu_item", %{truck: truck} do
      valid_attrs = %{item_name: "some item_name", truck_id: truck.id}

      assert {:ok, %MenuItem{} = menu_item} = MenuItems.create_menu_item(valid_attrs)
      assert menu_item.item_name == "some item_name"
    end

    test "create_menu_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MenuItems.create_menu_item(@invalid_attrs)
    end

    test "update_menu_item/2 with valid data updates the menu_item" do
      menu_item = menu_item_fixture()
      update_attrs = %{item_name: "some updated item_name"}

      assert {:ok, %MenuItem{} = menu_item} = MenuItems.update_menu_item(menu_item, update_attrs)
      assert menu_item.item_name == "some updated item_name"
    end

    test "update_menu_item/2 with invalid data returns error changeset" do
      menu_item = menu_item_fixture()
      assert {:error, %Ecto.Changeset{}} = MenuItems.update_menu_item(menu_item, @invalid_attrs)
      assert menu_item == MenuItems.get_menu_item!(menu_item.id)
    end

    test "delete_menu_item/1 deletes the menu_item" do
      menu_item = menu_item_fixture()
      assert {:ok, %MenuItem{}} = MenuItems.delete_menu_item(menu_item)
      assert_raise Ecto.NoResultsError, fn -> MenuItems.get_menu_item!(menu_item.id) end
    end

    test "change_menu_item/1 returns a menu_item changeset" do
      menu_item = menu_item_fixture()
      assert %Ecto.Changeset{} = MenuItems.change_menu_item(menu_item)
    end
  end
end
