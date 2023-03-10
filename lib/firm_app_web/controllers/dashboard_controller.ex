defmodule FirmAppWeb.DashboardController do
  use FirmAppWeb, :controller

  plug(:put_layout, "dashboard.html")

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _, _current_user) do
    render(conn, "index.html")
  end
end
