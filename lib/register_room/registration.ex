defmodule RegisterRoom.Registration do
  import Ecto.Query, warn: false
  alias RegisterRoom.Repo

  alias RegisterRoom.Registration.Voucher

  def list_vouchers do
    Repo.all(Voucher)
    |> Enum.map(&voucher_dates_to_local(&1))
  end

  def get_voucher!(id) do
    Repo.get!(Voucher, id)
    |> voucher_dates_to_local()
  end

  def create_voucher(attrs \\ %{}) do
    %Voucher{}
    |> Voucher.changeset(attrs)
    |> voucher_dates_to_utc()
    |> Repo.insert()
  end

  def update_voucher(%Voucher{} = voucher, attrs) do
    voucher
    |> Voucher.changeset(attrs)
    |> voucher_dates_to_utc()
    |> Repo.update()
  end

  def change_voucher(%Voucher{} = voucher) do
    Voucher.changeset(voucher, %{})
  end

  defp voucher_dates_to_local(%Voucher{} = voucher) do
    Map.put(voucher, :due_date, utc_to_local(voucher.due_date))
  end

  defp voucher_dates_to_local(%Ecto.Changeset{} = voucher) do
    {_, utc_datetime} = Ecto.Changeset.fetch_field(voucher, :due_date)
    local_datetime = utc_to_local(utc_datetime)

    voucher
    |> Ecto.Changeset.change(due_date: local_datetime)
  end

  defp voucher_dates_to_utc(voucher_changeset) do
    {_, local_datetime} = Ecto.Changeset.fetch_field(voucher_changeset, :due_date)
    utc_datetime = local_to_utc(local_datetime)

    voucher_changeset
    |> Ecto.Changeset.change(due_date: utc_datetime)
  end

  defp local_to_utc(local_datetime) do
    {_, utc_datetime} = local_datetime |> DateTime.shift_zone("UTC")

    utc_datetime
  end

  defp utc_to_local(utc_datetime) do
    {_, local_datetime} = utc_datetime |> DateTime.shift_zone("Europe/Warsaw")

    local_datetime
  end
end
