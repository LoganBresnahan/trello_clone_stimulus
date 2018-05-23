# Added by Logan

  * `mix ecto.reset` to re-seed the DB
  * Run two instances on the same computer
  `export PORT=4000 && iex --sname one@YOUR_COMPUTER_NAME_HERE -S mix phx.server`
  `export PORT=4001 && iex --sname two@YOUR_COMPUTER_NAME_HERE -S mix phx.server`
  * Within the first iex console run
  `Node.connect(:"two@YOUR_COMPUTER_NAME_HERE")`
  * Check the nodes are connected
  `[node()|Node.list()]`
  * Run two instances on seperate computers within your local wifi network
  `export PORT=4000 && iex --name mac@YOUR_COMPUTER_LOCAL_IP_ADDRESS --cookie monster -S mix phx.server`
  `export PORT=4000 && iex --name linux@YOUR_COMPUTER_LOCAL_IP_ADDRESS --cookie monster -S mix phx.server`
  * Within the first iex console run
  `Node.connect(:"linux@YOUR_COMPUTER_LOCAL_IP_ADDRESS")`
  * Check the nodes are connected
  `[node()|Node.list()]`


# TrelloCloneStimulus

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `export PORT=4000 && mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
