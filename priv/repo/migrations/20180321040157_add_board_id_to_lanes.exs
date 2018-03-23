defmodule TrelloCloneStimulus.Repo.Migrations.AddBoardIdToLanes do
  use Ecto.Migration

  def change do
    alter table(:lanes) do
      add :board_id, references(:boards, on_delete: :delete_all)
    end
  end
end
