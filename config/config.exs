# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trello_clone_stimulus,
  ecto_repos: [TrelloCloneStimulus.Repo]

# Configures the endpoint
config :trello_clone_stimulus, TrelloCloneStimulusWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mJUYKB2FsbVX4e42im2HRBAlGmWUJbASaefiloFbPE7zlUhcAGKpAV9rwl6qetjB",
  render_errors: [view: TrelloCloneStimulusWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TrelloCloneStimulus.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
