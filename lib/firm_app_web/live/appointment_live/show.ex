defmodule FirmAppWeb.AppointmentLive.Show do
  use FirmAppWeb, :live_view

  alias FirmApp.Meeting

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:appointment, Meeting.get_appointment!(id))}
  end

  defp page_title(:show), do: "Show Appointment"
  defp page_title(:edit), do: "Edit Appointment"
end
