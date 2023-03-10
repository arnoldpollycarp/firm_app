defmodule FirmAppWeb.UserConfirmationController do
  use FirmAppWeb, :controller

  alias FirmApp.Accounts
  alias FirmApp.Accounts.User
  alias FirmAppWeb.UserAuth
  alias FirmApp.Repo

  plug(:put_layout, "session.html")

  def new(conn, _params) do
    render(conn, "new.html")
  end


  def create(conn, %{"user" => %{"activation_code" => activation_code}}) do
    user = Repo.get_by(User, activation_code: activation_code)
    cond  do
      user ->
      {:ok, user}
        Accounts.update_user(user, %{"status"=> "ACTIVE"})
        conn
        |> put_flash(:info, "your account has been activated.")
        |> UserAuth.log_in_user(user)
        true ->
      {:error, user}
        conn
        |> put_flash(:error, "the activation code entered is incorrect")
        |> redirect(to: Routes.user_confirmation_path(conn, :new))

    end
  end

  # def create(conn, %{"user" => %{"email" => email}}) do
  #   if user = Accounts.get_user_by_email(email) do
  #     Accounts.deliver_user_confirmation_instructions(
  #       user,
  #       &Routes.user_confirmation_url(conn, :edit, &1)
  #     )
  #   end

  #   conn
  #   |> put_flash(
  #     :info,
  #     "If your email is in our system and it has not been confirmed yet, " <>
  #       "you will receive an email with instructions shortly."
  #   )
  #   |> redirect(to: "/")
  # end

  def edit(conn, %{"token" => token}) do
    render(conn, "edit.html", token: token)
  end

  # Do not log in the user after confirmation to avoid a
  # leaked token giving the user access to the account.
  def update(conn, %{"token" => token}) do
    case Accounts.confirm_user(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User confirmed successfully.")
        |> redirect(to: "/")

      :error ->
        # If there is a current user and the account was already confirmed,
        # then odds are that the confirmation link was already visited, either
        # by some automation or by the user themselves, so we redirect without
        # a warning message.
        case conn.assigns do
          %{current_user: %{confirmed_at: confirmed_at}} when not is_nil(confirmed_at) ->
            redirect(conn, to: "/")

          %{} ->
            conn
            |> put_flash(:error, "User confirmation link is invalid or it has expired.")
            |> redirect(to: "/")
        end
    end
  end
end
