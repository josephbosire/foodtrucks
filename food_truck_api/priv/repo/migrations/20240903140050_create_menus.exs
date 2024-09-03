defmodule FoodTruckApi.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus) do
      add :item_name, :string
      add :truck_id, references(:trucks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:menus, [:truck_id])
  end
end
