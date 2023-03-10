defmodule FirmAppWeb.FirmAppWeb.CaseController do
  use FirmAppWeb, :controller

  alias FirmApp.Court
  alias FirmApp.Court.Case
  alias FirmApp.Accounts
  alias FirmApp.Repo
  alias FirmAppWeb, :live_view
  alias FirmAppWeb.CaseLive.Index

  plug(:put_layout, "dashboard.html")

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _, current_user) do
    changeset = Court.change_case(%Case{})
    list_case =
      if current_user.usertype == "admin" do
        Court.list_case()
      else
        Court.client_list(current_user.id)
      end
      client_list = Accounts.client_list
      lawyer_list = Accounts.lawyer_list
    render(conn, "index.html", changeset: changeset, list_case: list_case, client_list: client_list, lawyer_list: lawyer_list)
  end

  def index(conn, _params, user) do
    LiveView.Controller.live_render(conn, Index, session: %{user: user})
  end

  def create(conn, %{"case" => case_params}, _current_user) do
    case IO.inspect(Court.create_case(case_params)) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Case details added successfully")
        |> redirect(to: Routes.case_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong. Contact system admin!!")
        |> redirect(to: Routes.case_path(conn, :index))
    end
  end

  def update_case(conn, %{"case" => case_params}, current_user) do
    case = Court.get_case!(case_params["id"])
    if current_user.usertype == "admin" or current_user.id == case.user_id do
      case Court.update_case(case, case_params) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "Case Details Updated Successfully")
          |> redirect(to: Routes.case_path(conn, :index))
        {:error, _} ->
          conn
          |> put_flash(:error, "Something went wrong kindly contact admin.")
          |> redirect(to: Routes.case_path(conn, :index))
      end
    else
      conn
      |> put_flash(:error, "You Are Not Authorized To Edit This Cases Details. Contact Admin for help")
      |> redirect(to: Routes.case_path(conn, :index))
    end
  end

  def delete(conn, %{"id"=>id}, current_user) do
    case = Court.get_case!(id)
    if current_user.usertype == "admin" do
      Repo.delete(case)
      conn
      |> put_flash(:info, "Deleted")
      |> redirect(to: Routes.case_path(conn, :index))
    else
      conn
      |> put_flash(:error, "You Are Not Authorized To Delete a Product. Contact Admin for help")
      |> redirect(to: Routes.case_path(conn, :index))
    end
  end
end
