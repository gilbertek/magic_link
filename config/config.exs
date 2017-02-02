# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :magic_link,
  ecto_repos: [MagicLink.Repo]

# Configures the endpoint
config :magic_link, MagicLink.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vI/MxZFeml+xdqbptsFB1W6sJUPzcNgNmpSwuUYZr+8bYKMk2jT2wpfDt8ruReJi",
  render_errors: [view: MagicLink.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MagicLink.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
