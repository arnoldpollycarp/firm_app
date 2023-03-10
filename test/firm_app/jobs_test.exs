defmodule FirmApp.JobsTest do
  use FirmApp.DataCase

  alias FirmApp.Jobs

  describe "task" do
    alias FirmApp.Jobs.Task

    import FirmApp.JobsFixtures

    @invalid_attrs %{deadline: nil, members: nil, name: nil, priority: nil, related_to: nil, start_date: nil, status: nil}

    test "list_task/0 returns all task" do
      task = task_fixture()
      assert Jobs.list_task() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Jobs.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{deadline: ~D[2022-10-17], members: "some members", name: "some name", priority: "some priority", related_to: 42, start_date: ~D[2022-10-17], status: "some status"}

      assert {:ok, %Task{} = task} = Jobs.create_task(valid_attrs)
      assert task.deadline == ~D[2022-10-17]
      assert task.members == "some members"
      assert task.name == "some name"
      assert task.priority == "some priority"
      assert task.related_to == 42
      assert task.start_date == ~D[2022-10-17]
      assert task.status == "some status"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{deadline: ~D[2022-10-18], members: "some updated members", name: "some updated name", priority: "some updated priority", related_to: 43, start_date: ~D[2022-10-18], status: "some updated status"}

      assert {:ok, %Task{} = task} = Jobs.update_task(task, update_attrs)
      assert task.deadline == ~D[2022-10-18]
      assert task.members == "some updated members"
      assert task.name == "some updated name"
      assert task.priority == "some updated priority"
      assert task.related_to == 43
      assert task.start_date == ~D[2022-10-18]
      assert task.status == "some updated status"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_task(task, @invalid_attrs)
      assert task == Jobs.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Jobs.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Jobs.change_task(task)
    end
  end
end
