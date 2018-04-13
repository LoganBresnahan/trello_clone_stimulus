defmodule TrelloCloneStimulus.Repo.Migrations.AddColorToPanels do
  use Ecto.Migration

  def change do
    alter table(:panels) do
      add :color, :string, default: "white"
    end
  end
end
