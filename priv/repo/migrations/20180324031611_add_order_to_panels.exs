defmodule TrelloCloneStimulus.Repo.Migrations.AddOrderToPanels do
  use Ecto.Migration

  def change do
    alter table(:panels) do
      add :order, :integer
    end
  end
end
