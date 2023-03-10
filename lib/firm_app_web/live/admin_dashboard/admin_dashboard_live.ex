defmodule FirmAppWeb.AdminDashboardLive do
  use FirmAppWeb, :live_view

  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end
end
