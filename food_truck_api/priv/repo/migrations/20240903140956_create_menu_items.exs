defmodule FoodTruckApi.Repo.Migrations.CreateMenuItems do
  use Ecto.Migration

  def change do
    create table(:menu_items) do
      add :item_name, :string
      add :truck_id, references(:trucks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:menu_items, [:truck_id])
  end
end
