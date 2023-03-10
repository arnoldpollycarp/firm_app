defmodule FirmAppWeb.ClientLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Customer
  alias FirmApp.Customer.Client
  alias FirmApp.Accounts.User
  alias FirmApp.Accounts

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :client_collection, list_client())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "EDIT USER DETAILS")
    |> assign(:client, Accounts.get_client!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:client, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Client")
    |> assign(:client, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    client = Accounts.get_client!(id)
    {:ok, _} = Accounts.delete_client(client)

    {:noreply, assign(socket, :client_collection, list_client())}
  end

  defp list_client do
    Accounts.list_client()
  end
end
