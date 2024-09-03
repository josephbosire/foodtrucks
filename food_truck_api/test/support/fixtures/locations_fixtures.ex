defmodule FoodTruckApi.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckApi.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    truck = FoodTruckApi.TrucksFixtures.truck_fixture()

    {:ok, location} =
      attrs
      |> Enum.into(%{
        latitude: "120.5",
        longitude: "120.5",
        status: "some status",
        truck_id: truck.id
      })
      |> FoodTruckApi.Locations.create_location()

    location
  end
end
