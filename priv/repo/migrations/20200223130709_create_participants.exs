defmodule RegisterRoom.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :name, :string
      add :surname, :string
      add :firm, :string
      add :position, :string
      add :email, :string
      add :voucher_id, references(:vouchers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:participants, [:voucher_id])
  end
end
