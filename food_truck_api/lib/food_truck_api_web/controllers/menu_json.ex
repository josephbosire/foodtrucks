defmodule FoodTruckApiWeb.MenuJSON do
  alias FoodTruckApi.Menus.Menu

  @doc """
  Renders a list of menus.
  """
  def index(%{menus: menus}) do
    %{data: for(menu <- menus, do: data(menu))}
  end

  @doc """
  Renders a single menu.
  """
  def show(%{menu: menu}) do
    %{data: data(menu)}
  end

  defp data(%Menu{} = menu) do
    %{
      id: menu.id,
      item_name: menu.item_name
    }
  end
end
