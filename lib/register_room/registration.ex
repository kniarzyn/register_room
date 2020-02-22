defmodule RegisterRoom.Registration do
  import Ecto.Query, warn: false
  alias RegisterRoom.Repo

  alias RegisterRoom.Registration.Voucher

  def list_vouchers do
    Repo.all(Voucher)
  end

  def get_voucher!(id), do: Repo.get!(Voucher, id)

  def create_voucher(attrs \\ %{}) do
    %Voucher{}
    |> Voucher.changeset(attrs)
    |> Repo.insert()
  end

  def update_voucher(%Voucher{} = voucher, attrs) do
    voucher
    |> Voucher.changeset(attrs)
    |> Repo.update()
  end

  def change_voucher(%Voucher{} = voucher) do
    Voucher.changeset(voucher, %{})
  end
end
