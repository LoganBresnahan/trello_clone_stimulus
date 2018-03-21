defmodule TrelloCloneStimulus.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :alias, :string
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :alias, :email, :password])
    |> validate_required([:name, :alias, :email, :password])
  end
end
