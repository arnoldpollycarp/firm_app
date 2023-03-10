defmodule FirmAppWeb.VendorLiveTest do
  use FirmAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import FirmApp.SupplierFixtures

  @create_attrs %{id_number: "some id_number", mobile: "some mobile", name: "some name", product: "some product", status: "some status"}
  @update_attrs %{id_number: "some updated id_number", mobile: "some updated mobile", name: "some updated name", product: "some updated product", status: "some updated status"}
  @invalid_attrs %{id_number: nil, mobile: nil, name: nil, product: nil, status: nil}

  defp create_vendor(_) do
    vendor = vendor_fixture()
    %{vendor: vendor}
  end

  describe "Index" do
    setup [:create_vendor]

    test "lists all vendor", %{conn: conn, vendor: vendor} do
      {:ok, _index_live, html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Listing Vendor"
      assert html =~ vendor.id_number
    end

    test "saves new vendor", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("a", "New Vendor") |> render_click() =~
               "New Vendor"

      assert_patch(index_live, Routes.vendor_index_path(conn, :new))

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vendor-form", vendor: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Vendor created successfully"
      assert html =~ "some id_number"
    end

    test "updates vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("#vendor-#{vendor.id} a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(index_live, Routes.vendor_index_path(conn, :edit, vendor))

      assert index_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vendor-form", vendor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_index_path(conn, :index))

      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated id_number"
    end

    test "deletes vendor in listing", %{conn: conn, vendor: vendor} do
      {:ok, index_live, _html} = live(conn, Routes.vendor_index_path(conn, :index))

      assert index_live |> element("#vendor-#{vendor.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vendor-#{vendor.id}")
    end
  end

  describe "Show" do
    setup [:create_vendor]

    test "displays vendor", %{conn: conn, vendor: vendor} do
      {:ok, _show_live, html} = live(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert html =~ "Show Vendor"
      assert html =~ vendor.id_number
    end

    test "updates vendor within modal", %{conn: conn, vendor: vendor} do
      {:ok, show_live, _html} = live(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vendor"

      assert_patch(show_live, Routes.vendor_show_path(conn, :edit, vendor))

      assert show_live
             |> form("#vendor-form", vendor: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#vendor-form", vendor: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vendor_show_path(conn, :show, vendor))

      assert html =~ "Vendor updated successfully"
      assert html =~ "some updated id_number"
    end
  end
end
