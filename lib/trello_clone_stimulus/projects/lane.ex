defmodule TrelloCloneStimulus.Projects.Lane do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Projects.Board
  alias TrelloCloneStimulus.Projects.Panel


  schema "lanes" do
    field :title, :string
    field :order, :integer
    field :color, :string, default: "white"
    belongs_to :board, Board
    has_many :panels, Panel

    timestamps()
  end

  @doc false
  def changeset(lane, attrs) do
    lane
    |> cast(attrs, [:title, :order, :color])
    |> validate_required([:title])
    |> put_assoc(:board, attrs.board)
  end
end
