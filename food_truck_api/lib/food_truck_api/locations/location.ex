defmodule FoodTruckApi.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :status, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :truck_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:latitude, :longitude, :status])
    |> validate_required([:latitude, :longitude, :status])
  end
end
