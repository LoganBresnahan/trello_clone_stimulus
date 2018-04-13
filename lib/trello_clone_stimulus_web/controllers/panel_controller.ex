defmodule TrelloCloneStimulusWeb.PanelController do
  use TrelloCloneStimulusWeb, :controller

  alias TrelloCloneStimulus.Repo
  alias TrelloCloneStimulus.Projects.Panel

  def update(conn, params = %{"to_lane" => "lane-"<>lane_id}) do

    params["to_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"panel-"<>id, index}) ->
      Repo.get!(Panel, id)
      |> Ecto.Changeset.change(order: index, lane_id: String.to_integer(lane_id))
      |> Repo.update!()
    end)
    |> Enum.to_list()

    params["from_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"panel-"<>id, index}) ->
      Repo.get!(Panel, id)
      |> Ecto.Changeset.change(order: index)
      |> Repo.update!()
    end)
    |> Enum.to_list()

    json conn, ""
  end
end
