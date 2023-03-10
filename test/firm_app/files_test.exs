defmodule FirmApp.FilesTest do
  use FirmApp.DataCase

  alias FirmApp.Files

  describe "upload" do
    alias FirmApp.Files.Uploads

    import FirmApp.FilesFixtures

    @invalid_attrs %{case_id: nil, name: nil, status: nil, user_id: nil}

    test "list_upload/0 returns all upload" do
      uploads = uploads_fixture()
      assert Files.list_upload() == [uploads]
    end

    test "get_uploads!/1 returns the uploads with given id" do
      uploads = uploads_fixture()
      assert Files.get_uploads!(uploads.id) == uploads
    end

    test "create_uploads/1 with valid data creates a uploads" do
      valid_attrs = %{case_id: 42, name: "some name", status: "some status", user_id: 42}

      assert {:ok, %Uploads{} = uploads} = Files.create_uploads(valid_attrs)
      assert uploads.case_id == 42
      assert uploads.name == "some name"
      assert uploads.status == "some status"
      assert uploads.user_id == 42
    end

    test "create_uploads/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Files.create_uploads(@invalid_attrs)
    end

    test "update_uploads/2 with valid data updates the uploads" do
      uploads = uploads_fixture()
      update_attrs = %{case_id: 43, name: "some updated name", status: "some updated status", user_id: 43}

      assert {:ok, %Uploads{} = uploads} = Files.update_uploads(uploads, update_attrs)
      assert uploads.case_id == 43
      assert uploads.name == "some updated name"
      assert uploads.status == "some updated status"
      assert uploads.user_id == 43
    end

    test "update_uploads/2 with invalid data returns error changeset" do
      uploads = uploads_fixture()
      assert {:error, %Ecto.Changeset{}} = Files.update_uploads(uploads, @invalid_attrs)
      assert uploads == Files.get_uploads!(uploads.id)
    end

    test "delete_uploads/1 deletes the uploads" do
      uploads = uploads_fixture()
      assert {:ok, %Uploads{}} = Files.delete_uploads(uploads)
      assert_raise Ecto.NoResultsError, fn -> Files.get_uploads!(uploads.id) end
    end

    test "change_uploads/1 returns a uploads changeset" do
      uploads = uploads_fixture()
      assert %Ecto.Changeset{} = Files.change_uploads(uploads)
    end
  end
end
