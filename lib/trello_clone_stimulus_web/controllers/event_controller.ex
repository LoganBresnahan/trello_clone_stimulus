defmodule TrelloCloneStimulusWeb.EventController do
  use TrelloCloneStimulusWeb, :controller

  alias TrelloCloneStimulus.Repo
  alias TrelloCloneStimulus.Projects.Board
  alias TrelloCloneStimulus.Projects.Lane
  alias TrelloCloneStimulus.Projects.Panel

  def content_event(conn, %{"model_info" => "panel-title-"<>id, "content" => content}) do
    Repo.get!(Panel, id)
    |> Ecto.Changeset.change(title: content)
    |> Repo.update!()

    json conn, ""
  end
  def content_event(conn, %{"model_info" => "panel-content-"<>id, "content" => content}) do
    Repo.get!(Panel, id)
    |> Ecto.Changeset.change(content: content)
    |> Repo.update!()

    json conn, ""
  end
  def content_event(conn, %{"model_info" => "lane-title-"<>id, "content" => content}) do
    Repo.get!(Lane, id)
    |> Ecto.Changeset.change(title: content)
    |> Repo.update!()

    json conn, ""
  end
  def content_event(conn, %{"model_info" => "board-name-"<>id, "content" => content}) do
    Repo.get!(Board, id)
    |> Ecto.Changeset.change(name: content)
    |> Repo.update!()

    json conn, ""
  end

  def color_event(conn, %{"model_info" => "panel-"<>id, "color" => color}) do
    Repo.get!(Panel, id)
    |> Ecto.Changeset.change(color: color)
    |> Repo.update!()

    json conn, ""
  end
  def color_event(conn, %{"model_info" => "lane-"<>id, "color" => color}) do
    Repo.get!(Lane, id)
    |> Ecto.Changeset.change(color: color)
    |> Repo.update!()

    json conn, ""
  end
  def color_event(conn, %{"model_info" => "board-"<>id, "color" => color}) do
    Repo.get!(Board, id)
    |> Ecto.Changeset.change(color: color)
    |> Repo.update!()

    json conn, ""
  end

  def order_event(conn, params = %{"to" => "lane-"<>to_id}) do
    params["to_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"panel-"<>id, index}) ->
      Repo.get!(Panel, id)
      |> Ecto.Changeset.change(order: index, lane_id: String.to_integer(to_id))
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
  def order_event(conn, params = %{"to" => "board-"<>to_id}) do
    params["to_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"lane-"<>id, index}) ->
      Repo.get!(Lane, id)
      |> Ecto.Changeset.change(order: index, board_id: String.to_integer(to_id))
      |> Repo.update!()
    end)
    |> Enum.to_list()

    params["from_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"lane-"<>id, index}) ->
      Repo.get!(Lane, id)
      |> Ecto.Changeset.change(order: index)
      |> Repo.update!()
    end)
    |> Enum.to_list()

    json conn, ""
  end
  def order_event(conn, params) do
    params["to_children"]
    |> Stream.with_index()
    |> Stream.each(fn({"board-"<>id, index}) ->
      Repo.get!(Board, id)
      |> Ecto.Changeset.change(order: index)
      |> Repo.update!()
    end)
    |> Enum.to_list()

    json conn, ""
  end
end
