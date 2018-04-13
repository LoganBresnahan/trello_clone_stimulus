defmodule TrelloCloneStimulus.Repo.Migrations.AddOrderAndColorToLanes do
  use Ecto.Migration

  def change do
    alter table(:lanes) do
      add :order, :integer
      add :color, :string, default: "white"
    end
  end
end
