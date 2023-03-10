defmodule FirmApp.SupplierTest do
  use FirmApp.DataCase

  alias FirmApp.Supplier

  describe "vendor" do
    alias FirmApp.Supplier.Vendor

    import FirmApp.SupplierFixtures

    @invalid_attrs %{id_number: nil, mobile: nil, name: nil, product: nil, status: nil}

    test "list_vendor/0 returns all vendor" do
      vendor = vendor_fixture()
      assert Supplier.list_vendor() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id" do
      vendor = vendor_fixture()
      assert Supplier.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor" do
      valid_attrs = %{id_number: "some id_number", mobile: "some mobile", name: "some name", product: "some product", status: "some status"}

      assert {:ok, %Vendor{} = vendor} = Supplier.create_vendor(valid_attrs)
      assert vendor.id_number == "some id_number"
      assert vendor.mobile == "some mobile"
      assert vendor.name == "some name"
      assert vendor.product == "some product"
      assert vendor.status == "some status"
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supplier.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor" do
      vendor = vendor_fixture()
      update_attrs = %{id_number: "some updated id_number", mobile: "some updated mobile", name: "some updated name", product: "some updated product", status: "some updated status"}

      assert {:ok, %Vendor{} = vendor} = Supplier.update_vendor(vendor, update_attrs)
      assert vendor.id_number == "some updated id_number"
      assert vendor.mobile == "some updated mobile"
      assert vendor.name == "some updated name"
      assert vendor.product == "some updated product"
      assert vendor.status == "some updated status"
    end

    test "update_vendor/2 with invalid data returns error changeset" do
      vendor = vendor_fixture()
      assert {:error, %Ecto.Changeset{}} = Supplier.update_vendor(vendor, @invalid_attrs)
      assert vendor == Supplier.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{}} = Supplier.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> Supplier.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset" do
      vendor = vendor_fixture()
      assert %Ecto.Changeset{} = Supplier.change_vendor(vendor)
    end
  end
end
