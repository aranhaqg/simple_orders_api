# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_orders_api,
  ecto_repos: [SimpleOrdersApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :simple_orders_api, SimpleOrdersApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dmIgz2Cd3fWiunavvWBlqHa6hPNGptlrai+VoPEvK+v1xWI9T8SESRYyB4FJCPnT",
  render_errors: [view: SimpleOrdersApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SimpleOrdersApi.PubSub,
  live_view: [signing_salt: "GiTJ2xb+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
