defmodule RegisterRoom.Registration.Voucher do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vouchers" do
    field :due_date, :utc_datetime
    field :info, :string
    field :token, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(voucher, attrs) do
    voucher
    |> cast(attrs, [:token, :info, :due_date])
    |> validate_required([:token, :info, :due_date])
  end
end
