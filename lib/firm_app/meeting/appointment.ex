defmodule FirmApp.Meeting.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  alias FirmApp.Accounts.User

  schema "appointment" do
    field :date, :date
    field :place, :string
    field :reason, :string
    field :status, :string
    field :time, :time
    field :with, :integer
    belongs_to :user, User, foreign_key: :client_id

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:client_id, :date, :time, :with, :reason, :status, :place])
    |> validate_required([:client_id, :date, :time, :with, :reason, :status, :place])
  end
end
