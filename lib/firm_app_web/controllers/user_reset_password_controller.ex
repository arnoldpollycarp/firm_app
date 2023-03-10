defmodule FirmAppWeb.UserResetPasswordController do
  use FirmAppWeb, :controller

  alias FirmApp.Accounts
  alias FirmApp.Mailer

  plug(:put_layout, "session.html")
  plug :get_user_by_reset_password_token when action in [:edit, :update]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  # def create(conn, %{"user" => %{"email" => email}}) do
  #   if user = Accounts.get_user_by_email(email) do
  #     case Mailer.welcome_mail(user, activation_code) do
  #       {:ok, _} ->
  #         conn
  #         |> put_flash(:info, "user details added successfully, check email for activation code")
  #         |> redirect(to: Routes.user_registration_path(conn, :new))
  #       {:error, 403, _} ->
  #         conn
  #         |> put_flash(:error, "Slight issue uploading your details. Kindly contact admin")
  #         |> redirect(to: Routes.user_registration_path(conn, :new))
  #     end
  #   end
  #   conn
  #   |> put_flash(:info, "If your email is in our system, you will receive instructions to reset your password shortly.")
  #   |> redirect(to: "/")
  # end

  def edit(conn, _params) do
    render(conn, "edit.html", changeset: Accounts.change_user_password(conn.assigns.user))
  end

  # Do not log in the user after reset password to avoid a
  # leaked token giving the user access to the account.
  def update(conn, %{"user" => user_params}) do
    case Accounts.reset_user_password(conn.assigns.user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Password reset successfully.")
        |> redirect(to: Routes.user_session_path(conn, :new))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp get_user_by_reset_password_token(conn, _opts) do
    %{"token" => token} = conn.params

    if user = Accounts.get_user_by_reset_password_token(token) do
      conn |> assign(:user, user) |> assign(:token, token)
    else
      conn
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
