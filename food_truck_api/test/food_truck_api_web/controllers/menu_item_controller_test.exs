defmodule FoodTruckApiWeb.MenuItemControllerTest do
  use FoodTruckApiWeb.ConnCase

  import FoodTruckApi.MenuItemsFixtures

  alias FoodTruckApi.MenuItems.MenuItem

  @create_attrs %{
    item_name: "some item_name"
  }
  @update_attrs %{
    item_name: "some updated item_name"
  }
  @invalid_attrs %{item_name: nil}

  setup %{conn: conn} do
    truck = FoodTruckApi.TrucksFixtures.truck_fixture()
    {:ok, conn: put_req_header(conn, "accept", "application/json"), truck: truck}
  end

  describe "index" do
    test "lists all menu_items", %{conn: conn, truck: truck} do
      conn = get(conn, ~p"/api/trucks/#{truck}/menu_items")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create menu_item" do
    test "renders menu_item when data is valid", %{conn: conn, truck: truck} do
      conn = post(conn, ~p"/api/trucks/#{truck}/menu_items", menu_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/trucks/#{truck}/menu_items/#{id}")

      assert %{
               "id" => ^id,
               "item_name" => "some item_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, truck: truck} do
      conn = post(conn, ~p"/api/trucks/#{truck}/menu_items", menu_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update menu_item" do
    setup [:create_menu_item]

    test "renders menu_item when data is valid", %{
      conn: conn,
      menu_item: %MenuItem{id: id} = menu_item,
      truck: truck
    } do
      conn = put(conn, ~p"/api/trucks/#{truck}/menu_items/#{menu_item}", menu_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/trucks/#{truck}/menu_items/#{id}")

      assert %{
               "id" => ^id,
               "item_name" => "some updated item_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, menu_item: menu_item, truck: truck} do
      conn =
        put(conn, ~p"/api/trucks/#{truck}/menu_items/#{menu_item}", menu_item: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete menu_item" do
    setup [:create_menu_item]

    test "deletes chosen menu_item", %{conn: conn, menu_item: menu_item, truck: truck} do
      conn = delete(conn, ~p"/api/trucks/#{truck}/menu_items/#{menu_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/trucks/#{truck}/menu_items/#{menu_item}")
      end
    end
  end

  defp create_menu_item(_) do
    menu_item = menu_item_fixture()
    %{menu_item: menu_item}
  end
end
