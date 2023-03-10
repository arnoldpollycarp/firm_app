defmodule FirmAppWeb.VendorLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Supplier
  alias FirmApp.Supplier.Vendor

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :vendor_collection, list_vendor())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vendor")
    |> assign(:vendor, Supplier.get_vendor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vendor")
    |> assign(:vendor, %Vendor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vendor")
    |> assign(:vendor, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vendor = Supplier.get_vendor!(id)
    {:ok, _} = Supplier.delete_vendor(vendor)

    {:noreply, assign(socket, :vendor_collection, list_vendor())}
  end

  defp list_vendor do
    Supplier.list_vendor()
  end
end
