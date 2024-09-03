defmodule FoodTruckApi.LocationsTest do
  use FoodTruckApi.DataCase

  alias FoodTruckApi.Locations

  describe "locations" do
    alias FoodTruckApi.Locations.Location

    import FoodTruckApi.LocationsFixtures

    @invalid_attrs %{status: nil, latitude: nil, longitude: nil}

    setup do
      truck = FoodTruckApi.TrucksFixtures.truck_fixture()
      {:ok, truck: truck}
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location", %{truck: truck} do
      valid_attrs = %{
        status: "some status",
        latitude: "120.5",
        longitude: "120.5",
        truck_id: truck.id
      }

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.status == "some status"
      assert location.latitude == Decimal.new("120.5")
      assert location.longitude == Decimal.new("120.5")
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{status: "some updated status", latitude: "456.7", longitude: "456.7"}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.status == "some updated status"
      assert location.latitude == Decimal.new("456.7")
      assert location.longitude == Decimal.new("456.7")
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
