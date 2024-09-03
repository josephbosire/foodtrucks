defmodule FoodTruckApiWeb.TruckController do
  use FoodTruckApiWeb, :controller

  alias FoodTruckApi.Trucks
  alias FoodTruckApi.Trucks.Truck

  action_fallback FoodTruckApiWeb.FallbackController

  def index(conn, _params) do
    trucks = Trucks.list_trucks()
    render(conn, :index, trucks: trucks)
  end

  def create(conn, %{"truck" => truck_params}) do
    with {:ok, %Truck{} = truck} <- Trucks.create_truck(truck_params) do
      conn
      |> put_status(:created)
      |> render(:show, truck: truck)
    end
  end

  def show(conn, %{"id" => id}) do
    truck = Trucks.get_truck!(id)
    render(conn, :show, truck: truck)
  end

  def update(conn, %{"id" => id, "truck" => truck_params}) do
    truck = Trucks.get_truck!(id)

    with {:ok, %Truck{} = truck} <- Trucks.update_truck(truck, truck_params) do
      render(conn, :show, truck: truck)
    end
  end

  def delete(conn, %{"id" => id}) do
    truck = Trucks.get_truck!(id)

    with {:ok, %Truck{}} <- Trucks.delete_truck(truck) do
      send_resp(conn, :no_content, "")
    end
  end
end
