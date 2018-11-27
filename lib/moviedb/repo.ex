defmodule Moviedb.Repo do
  use Ecto.Repo,
    otp_app: :moviedb,
    adapter: Ecto.Adapters.Postgres
end
