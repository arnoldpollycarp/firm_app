defmodule FirmApp.Repo.Migrations.CreateUpload do
  use Ecto.Migration

  def change do
    create table(:upload) do
      add :name, :string
      add :case_id, :integer
      add :user_id, :integer
      add :status, :string

      timestamps()
    end
  end
end
