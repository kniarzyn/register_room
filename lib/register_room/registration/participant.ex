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

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:name, :surname, :firm, :position, :email])
    |> validate_required([:name, :surname, :firm, :position, :email])
  end
end
