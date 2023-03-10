defmodule FirmAppWeb.AppointmentLiveTest do
  use FirmAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import FirmApp.MeetingFixtures

  @create_attrs %{client_id: 42, date: %{day: 16, month: 10, year: 2022}, place: "some place", reason: "some reason", status: "some status", time: "some time", with: 42}
  @update_attrs %{client_id: 43, date: %{day: 17, month: 10, year: 2022}, place: "some updated place", reason: "some updated reason", status: "some updated status", time: "some updated time", with: 43}
  @invalid_attrs %{client_id: nil, date: %{day: 30, month: 2, year: 2022}, place: nil, reason: nil, status: nil, time: nil, with: nil}

  defp create_appointment(_) do
    appointment = appointment_fixture()
    %{appointment: appointment}
  end

  describe "Index" do
    setup [:create_appointment]

    test "lists all appointment", %{conn: conn, appointment: appointment} do
      {:ok, _index_live, html} = live(conn, Routes.appointment_index_path(conn, :index))

      assert html =~ "Listing Appointment"
      assert html =~ appointment.place
    end

    test "saves new appointment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.appointment_index_path(conn, :index))

      assert index_live |> element("a", "New Appointment") |> render_click() =~
               "New Appointment"

      assert_patch(index_live, Routes.appointment_index_path(conn, :new))

      assert index_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#appointment-form", appointment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.appointment_index_path(conn, :index))

      assert html =~ "Appointment created successfully"
      assert html =~ "some place"
    end

    test "updates appointment in listing", %{conn: conn, appointment: appointment} do
      {:ok, index_live, _html} = live(conn, Routes.appointment_index_path(conn, :index))

      assert index_live |> element("#appointment-#{appointment.id} a", "Edit") |> render_click() =~
               "Edit Appointment"

      assert_patch(index_live, Routes.appointment_index_path(conn, :edit, appointment))

      assert index_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#appointment-form", appointment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.appointment_index_path(conn, :index))

      assert html =~ "Appointment updated successfully"
      assert html =~ "some updated place"
    end

    test "deletes appointment in listing", %{conn: conn, appointment: appointment} do
      {:ok, index_live, _html} = live(conn, Routes.appointment_index_path(conn, :index))

      assert index_live |> element("#appointment-#{appointment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#appointment-#{appointment.id}")
    end
  end

  describe "Show" do
    setup [:create_appointment]

    test "displays appointment", %{conn: conn, appointment: appointment} do
      {:ok, _show_live, html} = live(conn, Routes.appointment_show_path(conn, :show, appointment))

      assert html =~ "Show Appointment"
      assert html =~ appointment.place
    end

    test "updates appointment within modal", %{conn: conn, appointment: appointment} do
      {:ok, show_live, _html} = live(conn, Routes.appointment_show_path(conn, :show, appointment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Appointment"

      assert_patch(show_live, Routes.appointment_show_path(conn, :edit, appointment))

      assert show_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#appointment-form", appointment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.appointment_show_path(conn, :show, appointment))

      assert html =~ "Appointment updated successfully"
      assert html =~ "some updated place"
    end
  end
end
