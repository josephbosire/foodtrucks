defmodule FoodTruckApiWeb.LocationJSON do
  alias FoodTruckApi.Locations.Location

  @doc """
  Renders a list of locations.
  """
  def index(%{locations: locations}) do
    %{data: for(location <- locations, do: data(location))}
  end

  @doc """
  Renders a single location.
  """
  def show(%{location: location}) do
    %{data: data(location)}
  end

  defp data(%Location{} = location) do
    %{
      id: location.id,
      latitude: location.latitude,
      longitude: location.longitude,
      status: location.status
    }
  end
end
