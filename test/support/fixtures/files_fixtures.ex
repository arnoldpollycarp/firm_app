defmodule FirmApp.FilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Files` context.
  """

  @doc """
  Generate a uploads.
  """
  def uploads_fixture(attrs \\ %{}) do
    {:ok, uploads} =
      attrs
      |> Enum.into(%{
        case_id: 42,
        name: "some name",
        status: "some status",
        user_id: 42
      })
      |> FirmApp.Files.create_uploads()

    uploads
  end
end
