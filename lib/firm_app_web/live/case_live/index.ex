defmodule FirmAppWeb.CaseLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Court
  alias FirmApp.Court.Case

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    list_case =
    if socket.assigns.current_user.usertype == "admin" do
      Court.list_case()
    else
      Court.client_list(socket.assigns.current_user.id)
    end
    {:ok, assign(socket, :case_collection, list_case)}
  end

  @impl true
  @spec handle_params(any, any, %{
          :assigns => atom | %{:live_action => :edit | :index | :new, optional(any) => any},
          optional(any) => any
        }) :: {:noreply, map}
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Case")
    |> assign(:case, Court.get_case!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Case")
    |> assign(:case, %Case{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Case")
    |> assign(:case, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    case = Court.get_case!(id)
    {:ok, _} = Court.delete_case(case)

    {:noreply, assign(socket, :case_collection, list_case())}
  end

  defp list_case do
    Court.list_case()
  end
end
