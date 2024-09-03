defmodule FoodTruckApi.MenuItems.MenuItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "menu_items" do
    field :item_name, :string

    belongs_to :truck, FoodTruckApi.Trucks.Truck
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(menu_item, attrs) do
    menu_item
    |> cast(attrs, [:item_name, :truck_id])
    |> validate_required([:item_name, :truck_id])
  end
end
