defmodule TrelloCloneStimulus.GroupAccounts.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Accounts.User
  alias TrelloCloneStimulus.Projects.Board


  schema "groups" do
    field :name, :string
    many_to_many :users, User, join_through: "users_groups"
    has_many :boards, Board

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
