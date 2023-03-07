defmodule SimpleOrdersApi.Repo do
  use Ecto.Repo,
    otp_app: :simple_orders_api,
    adapter: Ecto.Adapters.Postgres
end
