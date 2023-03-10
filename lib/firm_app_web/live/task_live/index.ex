defmodule FirmAppWeb.TaskLive.Index do
  use FirmAppWeb, :live_view

  alias FirmApp.Jobs
  alias FirmApp.Jobs.Task

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :task_collection, list_task())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, Jobs.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Task")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Jobs.get_task!(id)
    {:ok, _} = Jobs.delete_task(task)

    {:noreply, assign(socket, :task_collection, list_task())}
  end

  defp list_task do
    Jobs.list_task()
  end
end
