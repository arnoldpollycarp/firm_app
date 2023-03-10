defmodule FirmAppWeb.ClientLive.FormComponent do
  use FirmAppWeb, :live_component

  alias FirmApp.Customer
  alias FirmApp.Accounts
  alias FirmApp.Mailer

  @impl true
  def update(%{client: client} = assigns, socket) do
    changeset = Accounts.change_user_registration(client)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.client
      |> Accounts.change_user_registration(user_params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_client(socket, socket.assigns.action, user_params)
  end

  defp save_client(socket, :edit, client_params) do
    case Accounts.update_client(socket.assigns.client, client_params) do
      {:ok, _client} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_client(socket, :new, client_params) do

    case  Accounts.register_user(client_params) do
      {:ok, _client} ->
        IO.inspect(client_params)
         Mailer.welcome_client_mail(client_params["email"], client_params["password"])
        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
