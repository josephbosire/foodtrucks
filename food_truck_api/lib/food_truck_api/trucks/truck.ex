defmodule FoodTruckApi.Trucks.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trucks" do
    field :block, :string
    field :name, :string
    field :status, :string
    field :type, :string
    field :address, :string
    field :lot, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [:name, :address, :block, :lot, :type, :status])
    |> validate_required([:name, :address, :block, :lot, :type, :status])
  end
end
