defmodule FoodTruckApi.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :name, :string
      add :address, :string
      add :block, :string
      add :lot, :string
      add :type, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
