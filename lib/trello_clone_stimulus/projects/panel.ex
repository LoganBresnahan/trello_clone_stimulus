defmodule TrelloCloneStimulus.Projects.Panel do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Projects.Lane


  schema "panels" do
    field :content, :string
    field :title, :string
    field :order, :integer
    field :color, :string, default: "white"
    belongs_to :lane, Lane, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(panel, attrs) do
    panel
    |> cast(attrs, [:title, :content, :order, :color])
    |> validate_required([:title, :content])
    |> put_assoc(:lane, attrs.lane)
  end
end
