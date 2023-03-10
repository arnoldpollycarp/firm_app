defmodule FirmAppWeb.CaseLive.FormComponent do
  use FirmAppWeb, :live_component

  alias FirmApp.Court
  alias FirmApp.Accounts


  @impl true
  def update(%{case: case} = assigns, socket) do
    changeset = Court.change_case(case)
    client_list = Accounts.client_list
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:client_list, client_list)}
  end

  @impl true
  def handle_event("validate", %{"case" => case_params}, socket) do
    changeset =
      socket.assigns.case
      |> Court.change_case(case_params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"case" => case_params}, socket) do
    save_case(socket, socket.assigns.action, case_params)
  end

  defp save_case(socket, :edit, case_params) do
    case Court.update_case(socket.assigns.case, case_params) do
      {:ok, _case} ->
        {:noreply,
         socket
         |> put_flash(:info, "Case updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_case(socket, :new, case_params) do
    case Court.create_case(case_params) do
      {:ok, _case} ->
        {:noreply,
         socket
         |> put_flash(:info, "Case created successfully")
         |> push_redirect(to: socket.assigns.return_to)}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
