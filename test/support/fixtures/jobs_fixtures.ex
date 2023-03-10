defmodule FirmApp.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Jobs` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        deadline: ~D[2022-10-17],
        members: "some members",
        name: "some name",
        priority: "some priority",
        related_to: 42,
        start_date: ~D[2022-10-17],
        status: "some status"
      })
      |> FirmApp.Jobs.create_task()

    task
  end
end
