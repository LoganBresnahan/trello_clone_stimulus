defmodule TrelloCloneStimulus.Repo.Migrations.AddOrderAndColorToBoards do
  use Ecto.Migration

  def change do
    alter table(:boards) do
      add :order, :integer
      add :color, :string, default: "white"
    end
  end
end
