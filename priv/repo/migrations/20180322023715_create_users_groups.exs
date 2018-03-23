defmodule TrelloCloneStimulus.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups) do

      timestamps()
    end

  end
end
