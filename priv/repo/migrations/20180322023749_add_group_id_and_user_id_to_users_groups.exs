defmodule TrelloCloneStimulus.Repo.Migrations.AddGroupIdAndUserIdToUsersGroups do
  use Ecto.Migration

  def change do
    alter table(:users_groups) do
      add :user_id, references(:users)
      add :group_id, references(:groups)
    end
  end
end
