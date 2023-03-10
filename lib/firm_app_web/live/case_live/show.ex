defmodule FirmAppWeb.CaseLive.Show do
  use FirmAppWeb, :live_view

  alias FirmApp.Files.Document
  alias FirmApp.Court

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:case, Court.get_case!(id))
     |> assign(:document, %Document{})}
  end



  defp page_title(:show), do: "Show Case"
  defp page_title(:upload), do: "Upload Case Files"
end
