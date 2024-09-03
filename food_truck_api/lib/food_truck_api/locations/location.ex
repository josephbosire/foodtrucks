defmodule FoodTruckApi.Locations.Location do
  alias FoodTruckApi.Trucks.Truck
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :status, :string
    field :latitude, :decimal
    field :longitude, :decimal

    belongs_to :truck, Truck
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:latitude, :longitude, :status, :truck_id])
    |> validate_required([:latitude, :longitude, :status, :truck_id])
  end
end
