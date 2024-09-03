defmodule FoodTruckApiWeb.LocationControllerTest do
  use FoodTruckApiWeb.ConnCase

  import FoodTruckApi.LocationsFixtures

  alias FoodTruckApi.Locations.Location

  @create_attrs %{
    status: "some status",
    latitude: "120.5",
    longitude: "120.5"
  }
  @update_attrs %{
    status: "some updated status",
    latitude: "456.7",
    longitude: "456.7"
  }
  @invalid_attrs %{status: nil, latitude: nil, longitude: nil}

  setup %{conn: conn} do
    truck = FoodTruckApi.TrucksFixtures.truck_fixture()
    {:ok, conn: put_req_header(conn, "accept", "application/json"), truck: truck}
  end

  describe "index" do
    test "lists all locations", %{conn: conn, truck: truck} do
      conn = get(conn, ~p"/api/trucks/#{truck}/locations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create location" do
    test "renders location when data is valid", %{conn: conn, truck: truck} do
      conn = post(conn, ~p"/api/trucks/#{truck}/locations", location: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/trucks/#{truck}/locations/#{id}")

      assert %{
               "id" => ^id,
               "latitude" => "120.5",
               "longitude" => "120.5",
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, truck: truck} do
      conn = post(conn, ~p"/api/trucks/#{truck}/locations", location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update location" do
    setup [:create_location]

    test "renders location when data is valid", %{
      conn: conn,
      location: %Location{id: id} = location,
      truck: truck
    } do
      conn = put(conn, ~p"/api/trucks/#{truck}/locations/#{location}", location: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/trucks/#{truck}/locations/#{id}")

      assert %{
               "id" => ^id,
               "latitude" => "456.7",
               "longitude" => "456.7",
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, location: location, truck: truck} do
      conn = put(conn, ~p"/api/trucks/#{truck}/locations/#{location}", location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location, truck: truck} do
      conn = delete(conn, ~p"/api/trucks/#{truck}/locations/#{location}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/trucks/#{truck}/locations/#{location}")
      end
    end
  end

  defp create_location(_) do
    location = location_fixture()
    %{location: location}
  end
end
