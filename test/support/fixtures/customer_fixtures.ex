defmodule FirmApp.CustomerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Customer` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        phone: "some phone",
        status: "some status"
      })
      |> FirmApp.Customer.create_client()

    client
  end
end
