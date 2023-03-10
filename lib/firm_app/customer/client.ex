defmodule FirmApp.Customer.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "client" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :phone, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:firstname, :email, :phone, :lastname, :status])
    |> validate_required([:firstname, :email, :phone, :lastname, :status])
  end
end
