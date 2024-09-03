defmodule FoodTruckApi.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :latitude, :decimal
      add :longitude, :decimal
      add :status, :string
      add :truck_id, references(:trucks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:locations, [:truck_id])
  end
end
