defmodule SimpleOrdersApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :balance, :decimal

      timestamps()
    end

    create unique_index(:users, [:name])
  end
end
