defmodule FirmAppWeb.FilesLive do
  use FirmAppWeb, :live_view

  alias FirmAppWeb.Files
  alias FirmApp.Files
  alias FirmApp.Files.Document
  alias FirmApp.Court

  @impl true
  def mount(%{"id" => id}, session, socket) do
    socket = assign_defaults(session, socket)
    if connected?(socket), do: Files.subscribe()
    files = Files.list_upload()
    changeset = Files.change_uploads(%Document{})
    cs = Court.get_case!(id)
    socket = assign(socket, files: files, changeset: changeset, cs: cs)

    socket =
      allow_upload(
        socket,
        :photo,
        accept: ~W(.png .jpg .docx .pdf),
        max_entries: 10,
        max_file_size: 10_000_000
      )
    {:ok,
     socket, temporary_assigns: [files: []]}
  end

  @impl true
  @spec handle_event(<<_::32, _::_*32>>, map, any) :: {:noreply, any}
  def handle_event("validate", %{"document" => document_params}, socket) do
    changeset =
      %Document{}
      |> Files.change_uploads(document_params)
      |> Map.put(:action, :insert)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"document" => document_params},socket) do
    case Files.create_uploads(document_params) do
      {:ok, _} ->
        changeset = Files.change_uploads(%Document{})
        {:noreply, assign(socket, changeset: changeset)}
      {:error, Ecto.Changeset = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_info({:document_created, document}, socket) do
    {:noreply, update(socket, :document_collection, fn documents -> [document | documents] end)}
  end
end
