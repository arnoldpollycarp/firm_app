defmodule FirmApp.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def change do
    create table(:case) do
      add :titel, :string
      add :usclient_id, :integer
      add :judge, :string
      add :reg_num, :string
      add :type, :string
      add :court, :string
      add :court_no, :string
      add :petitioner, :string
      add :respondent, :string
      add :next_date, :date
      add :lawyer, :string
      add :status, :string

      timestamps()
    end
  end
end
