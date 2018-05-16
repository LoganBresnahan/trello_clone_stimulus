# require IEx
defmodule TrelloCloneStimulusWeb.BoardController do
  use TrelloCloneStimulusWeb, :controller
  import Ecto

  alias TrelloCloneStimulus.Projects
  alias TrelloCloneStimulus.Projects.Board

  def index(conn, _params) do
    conn = Plug.Conn.assign(conn, :user_token, Ecto.UUID.generate())
    boards = Projects.list_boards()

    render(conn, "index.html", boards: boards)
  end

  def new(conn, _params) do
    changeset = Projects.change_board(%Board{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"board" => board_params}) do
    case Projects.create_board(board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: board_path(conn, :show, board))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Projects.get_board!(id)
    # IEx.pry
    render(conn, "show.html", board: board)
  end

  def edit(conn, %{"id" => id}) do
    board = Projects.get_board!(id)
    changeset = Projects.change_board(board)
    render(conn, "edit.html", board: board, changeset: changeset)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Projects.get_board!(id)

    case Projects.update_board(board, board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board updated successfully.")
        |> redirect(to: board_path(conn, :show, board))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", board: board, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Projects.get_board!(id)
    {:ok, _board} = Projects.delete_board(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: board_path(conn, :index))
  end
end
