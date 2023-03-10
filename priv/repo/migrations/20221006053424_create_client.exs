defmodule FirmApp.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:client) do
      add :firstname, :string
      add :email, :string
      add :phone, :string
      add :lastname, :string
      add :status, :string

      timestamps()
    end
  end
end
