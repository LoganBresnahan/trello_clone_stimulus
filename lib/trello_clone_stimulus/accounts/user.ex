defmodule TrelloCloneStimulus.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.GroupAccounts.Group


  schema "users" do
    field :alias, :string
    field :email, :string
    field :name, :string
    field :password, :string
    many_to_many :groups, Group, join_through: "users_groups"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :alias, :email, :password])
    |> validate_required([:name, :alias, :email, :password])
  end
end
