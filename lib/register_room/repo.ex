defmodule RegisterRoom.Repo do
  use Ecto.Repo,
    otp_app: :register_room,
    adapter: Ecto.Adapters.Postgres
end
