defmodule CraigslistTracker.Repo do
  use Ecto.Repo,
    otp_app: :craigslist_tracker,
    adapter: Ecto.Adapters.Postgres
end
