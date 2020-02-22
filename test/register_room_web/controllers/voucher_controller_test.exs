defmodule RegisterRoomWeb.VoucherControllerTest do
  use RegisterRoomWeb.ConnCase

  alias RegisterRoom.Registration

  @create_attrs %{due_date: "2010-04-17T14:00:00Z", info: "some info", token: "some token"}
  @update_attrs %{due_date: "2011-05-18T15:01:01Z", info: "some updated info", token: "some updated token"}
  @invalid_attrs %{due_date: nil, info: nil, token: nil}

  def fixture(:voucher) do
    {:ok, voucher} = Registration.create_voucher(@create_attrs)
    voucher
  end

  describe "index" do
    test "lists all vouchers", %{conn: conn} do
      conn = get(conn, Routes.voucher_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Vouchers"
    end
  end

  describe "new voucher" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.voucher_path(conn, :new))
      assert html_response(conn, 200) =~ "New Voucher"
    end
  end

  describe "create voucher" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.voucher_path(conn, :create), voucher: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.voucher_path(conn, :show, id)

      conn = get(conn, Routes.voucher_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Voucher"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.voucher_path(conn, :create), voucher: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Voucher"
    end
  end

  describe "edit voucher" do
    setup [:create_voucher]

    test "renders form for editing chosen voucher", %{conn: conn, voucher: voucher} do
      conn = get(conn, Routes.voucher_path(conn, :edit, voucher))
      assert html_response(conn, 200) =~ "Edit Voucher"
    end
  end

  describe "update voucher" do
    setup [:create_voucher]

    test "redirects when data is valid", %{conn: conn, voucher: voucher} do
      conn = put(conn, Routes.voucher_path(conn, :update, voucher), voucher: @update_attrs)
      assert redirected_to(conn) == Routes.voucher_path(conn, :show, voucher)

      conn = get(conn, Routes.voucher_path(conn, :show, voucher))
      assert html_response(conn, 200) =~ "some updated info"
    end

    test "renders errors when data is invalid", %{conn: conn, voucher: voucher} do
      conn = put(conn, Routes.voucher_path(conn, :update, voucher), voucher: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Voucher"
    end
  end

  describe "delete voucher" do
    setup [:create_voucher]

    test "deletes chosen voucher", %{conn: conn, voucher: voucher} do
      conn = delete(conn, Routes.voucher_path(conn, :delete, voucher))
      assert redirected_to(conn) == Routes.voucher_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.voucher_path(conn, :show, voucher))
      end
    end
  end

  defp create_voucher(_) do
    voucher = fixture(:voucher)
    {:ok, voucher: voucher}
  end
end
