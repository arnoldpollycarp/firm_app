defmodule FirmApp.SupplierFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FirmApp.Supplier` context.
  """

  @doc """
  Generate a vendor.
  """
  def vendor_fixture(attrs \\ %{}) do
    {:ok, vendor} =
      attrs
      |> Enum.into(%{
        id_number: "some id_number",
        mobile: "some mobile",
        name: "some name",
        product: "some product",
        status: "some status"
      })
      |> FirmApp.Supplier.create_vendor()

    vendor
  end
end
