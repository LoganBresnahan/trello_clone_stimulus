defmodule TrelloCloneStimulus.Repo.Migrations.AddLaneIdToPanels do
  use Ecto.Migration

  def change do
    alter table(:panels) do
      add :lane_id, references(:lanes, on_delete: :delete_all)
    end
  end
end
