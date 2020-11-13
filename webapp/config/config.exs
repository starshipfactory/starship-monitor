# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :webapp, WebappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2ZdCeO7TKrjZ0HdjiSIedqgUnDkK2fsfa8fOpQFrBZ+IGB6V8llm3xvzkHf2Gmhb",
  render_errors: [view: WebappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Webapp.PubSub,
  live_view: [signing_salt: "6knT4P2r"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
