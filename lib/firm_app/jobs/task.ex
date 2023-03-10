defmodule FirmApp.Jobs.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :deadline, :date
    field :members, :string
    field :name, :string
    field :priority, :string
    field :related_to, :integer
    field :start_date, :date
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :related_to, :start_date, :deadline, :members, :status, :priority])
    |> validate_required([:name, :related_to, :start_date, :deadline, :members, :status, :priority])
  end
end
