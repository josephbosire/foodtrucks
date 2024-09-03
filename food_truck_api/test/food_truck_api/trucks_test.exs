defmodule FoodTruckApi.TrucksTest do
  use FoodTruckApi.DataCase

  alias FoodTruckApi.Trucks

  describe "trucks" do
    alias FoodTruckApi.Trucks.Truck

    import FoodTruckApi.TrucksFixtures

    @invalid_attrs %{block: nil, name: nil, status: nil, type: nil, address: nil, lot: nil}

    test "list_trucks/0 returns all trucks" do
      truck = truck_fixture()
      assert Trucks.list_trucks() == [truck]
    end

    test "get_truck!/1 returns the truck with given id" do
      truck = truck_fixture()
      assert Trucks.get_truck!(truck.id) == truck
    end

    test "create_truck/1 with valid data creates a truck" do
      valid_attrs = %{block: "some block", name: "some name", status: "some status", type: "some type", address: "some address", lot: "some lot"}

      assert {:ok, %Truck{} = truck} = Trucks.create_truck(valid_attrs)
      assert truck.block == "some block"
      assert truck.name == "some name"
      assert truck.status == "some status"
      assert truck.type == "some type"
      assert truck.address == "some address"
      assert truck.lot == "some lot"
    end

    test "create_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trucks.create_truck(@invalid_attrs)
    end

    test "update_truck/2 with valid data updates the truck" do
      truck = truck_fixture()
      update_attrs = %{block: "some updated block", name: "some updated name", status: "some updated status", type: "some updated type", address: "some updated address", lot: "some updated lot"}

      assert {:ok, %Truck{} = truck} = Trucks.update_truck(truck, update_attrs)
      assert truck.block == "some updated block"
      assert truck.name == "some updated name"
      assert truck.status == "some updated status"
      assert truck.type == "some updated type"
      assert truck.address == "some updated address"
      assert truck.lot == "some updated lot"
    end

    test "update_truck/2 with invalid data returns error changeset" do
      truck = truck_fixture()
      assert {:error, %Ecto.Changeset{}} = Trucks.update_truck(truck, @invalid_attrs)
      assert truck == Trucks.get_truck!(truck.id)
    end

    test "delete_truck/1 deletes the truck" do
      truck = truck_fixture()
      assert {:ok, %Truck{}} = Trucks.delete_truck(truck)
      assert_raise Ecto.NoResultsError, fn -> Trucks.get_truck!(truck.id) end
    end

    test "change_truck/1 returns a truck changeset" do
      truck = truck_fixture()
      assert %Ecto.Changeset{} = Trucks.change_truck(truck)
    end
  end
end
