defmodule TestProj.Repo.Migrations.CreateCustomerLog do
  use Ecto.Migration

  def change do
    create table(:customer_log) do
      add :restaurant_names, :string
      add :food_names, :string
      add :first_name, :string
      add :food_cost, :float

      timestamps()
    end
  end
end
