defmodule TrelloCloneStimulus.Repo.Migrations.CreatePanels do
  use Ecto.Migration

  def change do
    create table(:panels) do
      add :title, :string
      add :content, :string

      timestamps()
    end

  end
end
