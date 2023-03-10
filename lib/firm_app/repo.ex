defmodule FirmApp.Repo do
  use Ecto.Repo,
    otp_app: :firm_app,
    adapter: Ecto.Adapters.MyXQL
end
