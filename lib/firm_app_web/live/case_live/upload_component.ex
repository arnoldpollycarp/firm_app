defmodule FirmAppWeb.CaseLive.UploadComponent do
  use FirmAppWeb, :live_component

  alias FirmApp.Files
  alias FirmApp.Files.Document
  alias FirmApp.Court


  @impl true
  def mount(socket) do
    {:ok, allow_upload(socket, :photo, accept: ~w(.jpg .jpeg .png .pdf .docx),
    max_entries: 10,
    max_file_size: 10_000_000)}
  end

  @impl true
  def update(%{id: id} = assigns, socket) do
    changeset = Files.change_uploads(%Document{})
    case = Court.get_case!(id)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(case: case)}
  end


  @impl true
  def handle_event("valiate", %{"document" => document_params}, socket) do
    changeset =
      socket.assigns.document
      |> Files.change_uploads(document_params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"document" => document_params}, socket) do
    save_document(socket, socket.assigns.action, document_params)
  end

  defp save_document(socket, :upload, document_params) do
    case Files.create_uploads(document_params) do
      {:ok, _case} ->
        {:noreply,
         socket
         |> put_flash(:info, "Files updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
