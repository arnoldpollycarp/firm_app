defmodule FirmAppWeb.AppointmentLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Meeting
  alias FirmApp.Meeting.Appointment

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do: IO.inspect Meeting.subscribe()
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :appointment_collection, list_appointment())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Appointment")
    |> assign(:appointment, Meeting.get_appointment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Appointment")
    |> assign(:appointment, %Appointment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Appointment")
    |> assign(:appointment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    appointment = Meeting.get_appointment!(id)
    {:ok, _} = Meeting.delete_appointment(appointment)

    {:noreply, assign(socket, :appointment_collection, list_appointment())}
  end

  @impl true
  def handle_info({:appointment_created, appointment}, socket) do
    {:noreply, update(socket, :appointment_collection, fn appointments -> [appointment | appointments] end)}
  end

  @impl true
  def handle_info({:appointment_update, appointment}, socket) do
    {:noreply, update(socket, :appointment_collection, fn appointments -> [appointment | appointments] end)}
  end

  defp list_appointment do
    Meeting.list_appointment()
  end
end
