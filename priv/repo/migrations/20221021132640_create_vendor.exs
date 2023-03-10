defmodule FirmApp.Repo.Migrations.CreateVendor do
  use Ecto.Migration

  def change do
    create table(:vendor) do
      add :name, :string
      add :mobile, :string
      add :status, :string
      add :product, :string
      add :id_number, :string

      timestamps()
    end
  end
end
