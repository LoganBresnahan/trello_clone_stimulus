defmodule TrelloCloneStimulus.Projects.Lane do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lanes" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(lane, attrs) do
    lane
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
