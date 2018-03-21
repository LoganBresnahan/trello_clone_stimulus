defmodule TrelloCloneStimulus.Repo.Migrations.CreateLanes do
  use Ecto.Migration

  def change do
    create table(:lanes) do
      add :title, :string

      timestamps()
    end

  end
end
