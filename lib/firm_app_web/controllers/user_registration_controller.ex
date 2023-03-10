defmodule FirmAppWeb.UserRegistrationController do
  use FirmAppWeb, :controller

  alias FirmApp.Accounts
  alias FirmApp.Accounts.User
  alias FirmApp.Mailer

  plug(:put_layout, "session.html")

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    activation_code = (SecureRandom.uuid()|> String.replace("-","")|> String.slice(0..5))
    user_params = Map.merge(user_params, %{"activation_code" => activation_code})
    case Accounts.register_user(user_params) do
      {:ok, user} ->
          case Mailer.welcome_mail(user, activation_code) do
            {:ok, _} ->
              conn
              |> put_flash(:info, "user details added successfully, check email for activation code")
              |> redirect(to: Routes.user_registration_path(conn, :new))
            {:error, 403, _} ->
              conn
              |> put_flash(:error, "Slight issue uploading your details. Kindly contact admin")
              |> redirect(to: Routes.user_registration_path(conn, :new))
          end
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end
end
