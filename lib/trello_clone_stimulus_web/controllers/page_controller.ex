defmodule TrelloCloneStimulusWeb.PageController do
  use TrelloCloneStimulusWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
