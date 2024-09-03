defmodule FoodTruckApi.Menus.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  schema "menus" do
    field :item_name, :string
    field :truck_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:item_name])
    |> validate_required([:item_name])
  end
end
