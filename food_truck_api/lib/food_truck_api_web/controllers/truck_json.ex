defmodule FoodTruckApiWeb.TruckJSON do
  alias FoodTruckApi.Trucks.Truck

  @doc """
  Renders a list of trucks.
  """
  def index(%{trucks: trucks}) do
    %{data: for(truck <- trucks, do: data(truck))}
  end

  @doc """
  Renders a single truck.
  """
  def show(%{truck: truck}) do
    %{data: data(truck)}
  end

  defp data(%Truck{} = truck) do
    %{
      id: truck.id,
      name: truck.name,
      address: truck.address,
      block: truck.block,
      lot: truck.lot,
      type: truck.type,
      status: truck.status
    }
  end
end
