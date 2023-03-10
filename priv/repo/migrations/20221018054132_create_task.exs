defmodule FirmApp.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :name, :string
      add :related_to, :integer
      add :start_date, :date
      add :deadline, :date
      add :members, :string
      add :status, :string
      add :priority, :string

      timestamps()
    end
  end
end
