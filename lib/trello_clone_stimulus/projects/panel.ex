defmodule TrelloCloneStimulus.Projects.Panel do
  use Ecto.Schema
  import Ecto.Changeset


  schema "panels" do
    field :content, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(panel, attrs) do
    panel
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
