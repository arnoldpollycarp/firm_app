defmodule FirmApp.Repo.Migrations.CreateAppointment do
  use Ecto.Migration

  def change do
    create table(:appointment) do
      add :client_id, :integer
      add :date, :date
      add :time, :string
      add :with, :integer
      add :reason, :string
      add :status, :string
      add :place, :string

      timestamps()
    end
  end
end
