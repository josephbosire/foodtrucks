defmodule FoodTruckApiWeb.LocationController do
  use FoodTruckApiWeb, :controller

  alias FoodTruckApi.Locations
  alias FoodTruckApi.Locations.Location

  action_fallback FoodTruckApiWeb.FallbackController

  def index(conn, _params) do
    locations = Locations.list_locations()
    render(conn, :index, locations: locations)
  end

  def create(conn, %{"location" => location_params, "truck_id" => truck_id}) do
    location_params = Map.put(location_params, "truck_id", truck_id)

    with {:ok, %Location{} = location} <- Locations.create_location(location_params) do
      conn
      |> put_status(:created)
      |> render(:show, location: location)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    render(conn, :show, location: location)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Locations.get_location!(id)

    with {:ok, %Location{} = location} <- Locations.update_location(location, location_params) do
      render(conn, :show, location: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Locations.get_location!(id)

    with {:ok, %Location{}} <- Locations.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
