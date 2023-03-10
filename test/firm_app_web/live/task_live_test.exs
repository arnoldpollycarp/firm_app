defmodule FirmAppWeb.TaskLiveTest do
  use FirmAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import FirmApp.JobsFixtures

  @create_attrs %{deadline: %{day: 17, month: 10, year: 2022}, members: "some members", name: "some name", priority: "some priority", related_to: 42, start_date: %{day: 17, month: 10, year: 2022}, status: "some status"}
  @update_attrs %{deadline: %{day: 18, month: 10, year: 2022}, members: "some updated members", name: "some updated name", priority: "some updated priority", related_to: 43, start_date: %{day: 18, month: 10, year: 2022}, status: "some updated status"}
  @invalid_attrs %{deadline: %{day: 30, month: 2, year: 2022}, members: nil, name: nil, priority: nil, related_to: nil, start_date: %{day: 30, month: 2, year: 2022}, status: nil}

  defp create_task(_) do
    task = task_fixture()
    %{task: task}
  end

  describe "Index" do
    setup [:create_task]

    test "lists all task", %{conn: conn, task: task} do
      {:ok, _index_live, html} = live(conn, Routes.task_index_path(conn, :index))

      assert html =~ "Listing Task"
      assert html =~ task.members
    end

    test "saves new task", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.task_index_path(conn, :index))

      assert index_live |> element("a", "New Task") |> render_click() =~
               "New Task"

      assert_patch(index_live, Routes.task_index_path(conn, :new))

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#task-form", task: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.task_index_path(conn, :index))

      assert html =~ "Task created successfully"
      assert html =~ "some members"
    end

    test "updates task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, Routes.task_index_path(conn, :index))

      assert index_live |> element("#task-#{task.id} a", "Edit") |> render_click() =~
               "Edit Task"

      assert_patch(index_live, Routes.task_index_path(conn, :edit, task))

      assert index_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#task-form", task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.task_index_path(conn, :index))

      assert html =~ "Task updated successfully"
      assert html =~ "some updated members"
    end

    test "deletes task in listing", %{conn: conn, task: task} do
      {:ok, index_live, _html} = live(conn, Routes.task_index_path(conn, :index))

      assert index_live |> element("#task-#{task.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#task-#{task.id}")
    end
  end

  describe "Show" do
    setup [:create_task]

    test "displays task", %{conn: conn, task: task} do
      {:ok, _show_live, html} = live(conn, Routes.task_show_path(conn, :show, task))

      assert html =~ "Show Task"
      assert html =~ task.members
    end

    test "updates task within modal", %{conn: conn, task: task} do
      {:ok, show_live, _html} = live(conn, Routes.task_show_path(conn, :show, task))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Task"

      assert_patch(show_live, Routes.task_show_path(conn, :edit, task))

      assert show_live
             |> form("#task-form", task: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#task-form", task: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.task_show_path(conn, :show, task))

      assert html =~ "Task updated successfully"
      assert html =~ "some updated members"
    end
  end
end
