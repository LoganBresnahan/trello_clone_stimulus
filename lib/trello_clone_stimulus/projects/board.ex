defmodule TrelloCloneStimulus.Projects.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Projects.Lane
  alias TrelloCloneStimulus.GroupAccounts.Group


  schema "boards" do
    field :name, :string
    has_many :lanes, Lane
    belongs_to :group, Group

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_assoc(:group, attrs.group)
  end
end
