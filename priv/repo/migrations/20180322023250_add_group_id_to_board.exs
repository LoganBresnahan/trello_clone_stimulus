defmodule TrelloCloneStimulus.Repo.Migrations.AddGroupIdToBoard do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add :group_id, references(:groups, on_delete: :delete_all)
    end
  end
end
