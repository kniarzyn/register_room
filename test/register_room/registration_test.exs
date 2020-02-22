defmodule RegisterRoom.RegistrationTest do
  use RegisterRoom.DataCase

  alias RegisterRoom.Registration

  describe "vouchers" do
    alias RegisterRoom.Registration.Voucher

    @valid_attrs %{due_date: "2010-04-17T14:00:00Z", info: "some info", token: "some token"}
    @update_attrs %{due_date: "2011-05-18T15:01:01Z", info: "some updated info", token: "some updated token"}
    @invalid_attrs %{due_date: nil, info: nil, token: nil}

    def voucher_fixture(attrs \\ %{}) do
      {:ok, voucher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registration.create_voucher()

      voucher
    end

    test "list_vouchers/0 returns all vouchers" do
      voucher = voucher_fixture()
      assert Registration.list_vouchers() == [voucher]
    end

    test "get_voucher!/1 returns the voucher with given id" do
      voucher = voucher_fixture()
      assert Registration.get_voucher!(voucher.id) == voucher
    end

    test "create_voucher/1 with valid data creates a voucher" do
      assert {:ok, %Voucher{} = voucher} = Registration.create_voucher(@valid_attrs)
      assert voucher.due_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert voucher.info == "some info"
      assert voucher.token == "some token"
    end

    test "create_voucher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registration.create_voucher(@invalid_attrs)
    end

    test "update_voucher/2 with valid data updates the voucher" do
      voucher = voucher_fixture()
      assert {:ok, %Voucher{} = voucher} = Registration.update_voucher(voucher, @update_attrs)
      assert voucher.due_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert voucher.info == "some updated info"
      assert voucher.token == "some updated token"
    end

    test "update_voucher/2 with invalid data returns error changeset" do
      voucher = voucher_fixture()
      assert {:error, %Ecto.Changeset{}} = Registration.update_voucher(voucher, @invalid_attrs)
      assert voucher == Registration.get_voucher!(voucher.id)
    end

    test "delete_voucher/1 deletes the voucher" do
      voucher = voucher_fixture()
      assert {:ok, %Voucher{}} = Registration.delete_voucher(voucher)
      assert_raise Ecto.NoResultsError, fn -> Registration.get_voucher!(voucher.id) end
    end

    test "change_voucher/1 returns a voucher changeset" do
      voucher = voucher_fixture()
      assert %Ecto.Changeset{} = Registration.change_voucher(voucher)
    end
  end
end
