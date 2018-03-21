defmodule TrelloCloneStimulusWeb.Router do
  use TrelloCloneStimulusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrelloCloneStimulusWeb do
    pipe_through :browser # Use the default browser stack

    get "/", BoardController, :index

    resources "/users", UserController
    resources "/boards", BoardController
    resources "/groups", GroupController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrelloCloneStimulusWeb do
  #   pipe_through :api
  # end
end
