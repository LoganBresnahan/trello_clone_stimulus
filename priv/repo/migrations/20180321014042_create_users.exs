defmodule TrelloCloneStimulus.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :alias, :string
      add :email, :string

      timestamps()
    end

  end
end
