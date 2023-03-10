defmodule FirmAppWeb.ClientLiveTest do
  use FirmAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import FirmApp.CustomerFixtures

  @create_attrs %{email: "some email", firstname: "some firstname", lastname: "some lastname", phone: "some phone", status: "some status"}
  @update_attrs %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", phone: "some updated phone", status: "some updated status"}
  @invalid_attrs %{email: nil, firstname: nil, lastname: nil, phone: nil, status: nil}

  defp create_client(_) do
    client = client_fixture()
    %{client: client}
  end

  describe "Index" do
    setup [:create_client]

    test "lists all client", %{conn: conn, client: client} do
      {:ok, _index_live, html} = live(conn, Routes.client_index_path(conn, :index))

      assert html =~ "Listing Client"
      assert html =~ client.email
    end

    test "saves new client", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.client_index_path(conn, :index))

      assert index_live |> element("a", "New Client") |> render_click() =~
               "New Client"

      assert_patch(index_live, Routes.client_index_path(conn, :new))

      assert index_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#client-form", client: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.client_index_path(conn, :index))

      assert html =~ "Client created successfully"
      assert html =~ "some email"
    end

    test "updates client in listing", %{conn: conn, client: client} do
      {:ok, index_live, _html} = live(conn, Routes.client_index_path(conn, :index))

      assert index_live |> element("#client-#{client.id} a", "Edit") |> render_click() =~
               "Edit Client"

      assert_patch(index_live, Routes.client_index_path(conn, :edit, client))

      assert index_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#client-form", client: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.client_index_path(conn, :index))

      assert html =~ "Client updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes client in listing", %{conn: conn, client: client} do
      {:ok, index_live, _html} = live(conn, Routes.client_index_path(conn, :index))

      assert index_live |> element("#client-#{client.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#client-#{client.id}")
    end
  end

  describe "Show" do
    setup [:create_client]

    test "displays client", %{conn: conn, client: client} do
      {:ok, _show_live, html} = live(conn, Routes.client_show_path(conn, :show, client))

      assert html =~ "Show Client"
      assert html =~ client.email
    end

    test "updates client within modal", %{conn: conn, client: client} do
      {:ok, show_live, _html} = live(conn, Routes.client_show_path(conn, :show, client))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Client"

      assert_patch(show_live, Routes.client_show_path(conn, :edit, client))

      assert show_live
             |> form("#client-form", client: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#client-form", client: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.client_show_path(conn, :show, client))

      assert html =~ "Client updated successfully"
      assert html =~ "some updated email"
    end
  end
end
