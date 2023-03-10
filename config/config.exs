# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :firm_app,
  ecto_repos: [FirmApp.Repo]

# Configures the endpoint
config :firm_app, FirmAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FirmAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FirmApp.PubSub,
  live_view: [signing_salt: "whmO+5tm"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :firm_app, FirmApp.Mailer,
#  adapter: Swoosh.Adapters.Mailgun,
#  api_key: "0923a813b77b086d166b63e0e1f56dec-c27bf672-bd2f69db",
#  domain: "https://api.mailgun.net/v3/sandbox6e397e1d2cdd462fa96948f37136f861.mailgun.org"
# # Swoosh API client is needed for adapters other than SMTP.
# config :swoosh, :api_client, Swoosh.ApiClient.Hackney

config :firm_app,
       mailgun_domain: "https://api.mailgun.net/v3/sandbox6e397e1d2cdd462fa96948f37136f861.mailgun.org",
       mailgun_key: "0923a813b77b086d166b63e0e1f56dec-c27bf672-bd2f69db"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"