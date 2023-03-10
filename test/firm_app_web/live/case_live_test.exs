defmodule FirmAppWeb.CaseLiveTest do
  use FirmAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import FirmApp.CourtFixtures

  @create_attrs %{court: "some court", court_no: "some court_no", judge: "some judge", lawyer: "some lawyer", next_date: %{day: 9, month: 10, year: 2022}, petitioner: "some petitioner", reg_num: "some reg_num", respondent: "some respondent", status: "some status", titel: "some titel", type: "some type", usclient_id: 42}
  @update_attrs %{court: "some updated court", court_no: "some updated court_no", judge: "some updated judge", lawyer: "some updated lawyer", next_date: %{day: 10, month: 10, year: 2022}, petitioner: "some updated petitioner", reg_num: "some updated reg_num", respondent: "some updated respondent", status: "some updated status", titel: "some updated titel", type: "some updated type", usclient_id: 43}
  @invalid_attrs %{court: nil, court_no: nil, judge: nil, lawyer: nil, next_date: %{day: 30, month: 2, year: 2022}, petitioner: nil, reg_num: nil, respondent: nil, status: nil, titel: nil, type: nil, usclient_id: nil}

  defp create_case(_) do
    case = case_fixture()
    %{case: case}
  end

  describe "Index" do
    setup [:create_case]

    test "lists all case", %{conn: conn, case: case} do
      {:ok, _index_live, html} = live(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Listing Case"
      assert html =~ case.court
    end

    test "saves new case", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("a", "New Case") |> render_click() =~
               "New Case"

      assert_patch(index_live, Routes.case_index_path(conn, :new))

      assert index_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#case-form", case: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Case created successfully"
      assert html =~ "some court"
    end

    test "updates case in listing", %{conn: conn, case: case} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("#case-#{case.id} a", "Edit") |> render_click() =~
               "Edit Case"

      assert_patch(index_live, Routes.case_index_path(conn, :edit, case))

      assert index_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#case-form", case: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_index_path(conn, :index))

      assert html =~ "Case updated successfully"
      assert html =~ "some updated court"
    end

    test "deletes case in listing", %{conn: conn, case: case} do
      {:ok, index_live, _html} = live(conn, Routes.case_index_path(conn, :index))

      assert index_live |> element("#case-#{case.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#case-#{case.id}")
    end
  end

  describe "Show" do
    setup [:create_case]

    test "displays case", %{conn: conn, case: case} do
      {:ok, _show_live, html} = live(conn, Routes.case_show_path(conn, :show, case))

      assert html =~ "Show Case"
      assert html =~ case.court
    end

    test "updates case within modal", %{conn: conn, case: case} do
      {:ok, show_live, _html} = live(conn, Routes.case_show_path(conn, :show, case))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Case"

      assert_patch(show_live, Routes.case_show_path(conn, :edit, case))

      assert show_live
             |> form("#case-form", case: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#case-form", case: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.case_show_path(conn, :show, case))

      assert html =~ "Case updated successfully"
      assert html =~ "some updated court"
    end
  end
end
