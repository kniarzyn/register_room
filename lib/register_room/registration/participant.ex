defmodule RegisterRoom.Registration.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  alias RegisterRoom.Registration.Voucher

  schema "participants" do
    field :email, :string
    field :firm, :string
    field :name, :string
    field :position, :string
    field :surname, :string
    belongs_to(:voucher, Voucher)

    field :token, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:name, :surname, :firm, :position, :email])
    |> validate_required([:name, :surname, :firm, :position, :email])
    |> validate_voucher(attrs)
  end

  defp validate_voucher(changeset, %{"token" => token}) do
    case RegisterRoom.Repo.get_by(Voucher, token: token) do
      %Voucher{} = voucher ->
        Ecto.Changeset.change(changeset, voucher_id: voucher.id)

      _ ->
        Ecto.Changeset.add_error(changeset, :token, "Niepoprawny kod promocyjny.")
    end
  end

  defp validate_voucher(changeset, _), do: changeset
end
