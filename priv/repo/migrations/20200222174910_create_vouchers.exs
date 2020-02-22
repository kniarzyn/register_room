defmodule RegisterRoom.Repo.Migrations.CreateVouchers do
  use Ecto.Migration

  def change do
    create table(:vouchers) do
      add :token, :string
      add :info, :string
      add :due_date, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:vouchers, [:token])
  end
end
