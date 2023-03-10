defmodule FirmApp.CustomerTest do
  use FirmApp.DataCase

  alias FirmApp.Customer

  describe "client" do
    alias FirmApp.Customer.Client

    import FirmApp.CustomerFixtures

    @invalid_attrs %{email: nil, firstname: nil, lastname: nil, phone: nil, status: nil}

    test "list_client/0 returns all client" do
      client = client_fixture()
      assert Customer.list_client() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Customer.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{email: "some email", firstname: "some firstname", lastname: "some lastname", phone: "some phone", status: "some status"}

      assert {:ok, %Client{} = client} = Customer.create_client(valid_attrs)
      assert client.email == "some email"
      assert client.firstname == "some firstname"
      assert client.lastname == "some lastname"
      assert client.phone == "some phone"
      assert client.status == "some status"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customer.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", phone: "some updated phone", status: "some updated status"}

      assert {:ok, %Client{} = client} = Customer.update_client(client, update_attrs)
      assert client.email == "some updated email"
      assert client.firstname == "some updated firstname"
      assert client.lastname == "some updated lastname"
      assert client.phone == "some updated phone"
      assert client.status == "some updated status"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Customer.update_client(client, @invalid_attrs)
      assert client == Customer.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Customer.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Customer.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Customer.change_client(client)
    end
  end
end
