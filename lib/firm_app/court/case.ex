defmodule FirmApp.Court.Case do
  use Ecto.Schema
  import Ecto.Changeset

  alias FirmApp.Accounts.User

  schema "case" do
    field :court, :string
    field :court_no, :string
    field :judge, :string
    belongs_to :law, User, foreign_key: :lawyer
    field :next_date, :date
    field :petitioner, :string
    field :reg_num, :string
    field :respondent, :string
    field :status, :string
    field :title, :string
    field :type, :string
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :client, User, foreign_key: :client_id
    timestamps()
  end

  @doc false
  def changeset(case, attrs) do
    case
    |> cast(attrs, [:title, :client_id, :judge, :reg_num, :type, :court, :court_no, :petitioner, :respondent, :next_date, :lawyer, :status, :user_id])
    |> validate_required([:title, :client_id, :judge, :reg_num, :type, :court, :court_no, :petitioner, :respondent, :next_date, :lawyer, :status, :user_id])
  end
end
