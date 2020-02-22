defmodule RegisterRoomWeb.VoucherController do
  use RegisterRoomWeb, :controller

  alias RegisterRoom.Registration
  alias RegisterRoom.Registration.Voucher

  def index(conn, _params) do
    vouchers = Registration.list_vouchers()
    render(conn, "index.html", vouchers: vouchers)
  end

  def new(conn, _params) do
    changeset = Registration.change_voucher(%Voucher{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"voucher" => voucher_params}) do
    case Registration.create_voucher(voucher_params) do
      {:ok, voucher} ->
        conn
        |> put_flash(:info, "Voucher created successfully.")
        |> redirect(to: Routes.voucher_path(conn, :show, voucher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    voucher = Registration.get_voucher!(id)
    render(conn, "show.html", voucher: voucher)
  end

  def edit(conn, %{"id" => id}) do
    voucher = Registration.get_voucher!(id)
    changeset = Registration.change_voucher(voucher)
    render(conn, "edit.html", voucher: voucher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "voucher" => voucher_params}) do
    voucher = Registration.get_voucher!(id)

    case Registration.update_voucher(voucher, voucher_params) do
      {:ok, voucher} ->
        conn
        |> put_flash(:info, "Voucher updated successfully.")
        |> redirect(to: Routes.voucher_path(conn, :show, voucher))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", voucher: voucher, changeset: changeset)
    end
  end
end
