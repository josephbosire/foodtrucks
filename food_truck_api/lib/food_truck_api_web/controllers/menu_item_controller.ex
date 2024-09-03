defmodule FoodTruckApiWeb.MenuItemController do
  use FoodTruckApiWeb, :controller

  alias FoodTruckApi.MenuItems
  alias FoodTruckApi.MenuItems.MenuItem

  action_fallback FoodTruckApiWeb.FallbackController

  def index(conn, _params) do
    menu_items = MenuItems.list_menu_items()
    render(conn, :index, menu_items: menu_items)
  end

  def create(conn, %{"menu_item" => menu_item_params, "truck_id" => truck_id}) do
    menu_item_params = Map.put(menu_item_params, "truck_id", truck_id)

    with {:ok, %MenuItem{} = menu_item} <- MenuItems.create_menu_item(menu_item_params) do
      conn
      |> put_status(:created)
      |> render(:show, menu_item: menu_item)
    end
  end

  def show(conn, %{"id" => id}) do
    menu_item = MenuItems.get_menu_item!(id)
    render(conn, :show, menu_item: menu_item)
  end

  def update(conn, %{"id" => id, "menu_item" => menu_item_params}) do
    menu_item = MenuItems.get_menu_item!(id)

    with {:ok, %MenuItem{} = menu_item} <- MenuItems.update_menu_item(menu_item, menu_item_params) do
      render(conn, :show, menu_item: menu_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu_item = MenuItems.get_menu_item!(id)

    with {:ok, %MenuItem{}} <- MenuItems.delete_menu_item(menu_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
