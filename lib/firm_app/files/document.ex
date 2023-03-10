defmodule FirmApp.Files.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "document" do
    field :case_id, :integer
    field :name, :string
    field :status, :string, default: "active"
    field :user_id, :integer
    field :photo_url, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :case_id, :user_id, :status, :photo_url])
    |> validate_required([:name, :case_id, :user_id])
  end
end
