defmodule FoodTruckApi.TrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckApi.Trucks` context.
  """

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        address: "some address",
        block: "some block",
        lot: "some lot",
        name: "some name",
        status: "some status",
        type: "some type"
      })
      |> FoodTruckApi.Trucks.create_truck()

    truck
  end
end
