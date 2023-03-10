defmodule FirmApp.Supplier.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendor" do
    field :id_number, :string
    field :mobile, :string
    field :name, :string
    field :product, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [:name, :mobile, :status, :product, :id_number])
    |> validate_required([:name, :mobile, :status, :product, :id_number])
  end
end
