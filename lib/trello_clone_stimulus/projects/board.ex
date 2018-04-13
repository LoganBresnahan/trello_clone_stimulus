defmodule TrelloCloneStimulus.Projects.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Projects.Lane
  alias TrelloCloneStimulus.GroupAccounts.Group


  schema "boards" do
    field :name, :string
    field :order, :integer, default: 0
    field :color, :string, default: "white"
    has_many :lanes, Lane
    belongs_to :group, Group

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :order, :color])
    |> validate_required([:name])
    |> put_assoc(:group, attrs.group)
  end
end
