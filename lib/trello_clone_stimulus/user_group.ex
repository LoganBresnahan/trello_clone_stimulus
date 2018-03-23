defmodule TrelloCloneStimulus.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset
  alias TrelloCloneStimulus.Accounts.User
  alias TrelloCloneStimulus.GroupAccounts.Group


  schema "users_groups" do
    belongs_to :user, User
    belongs_to :group, Group

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [])
    |> validate_required([])
    |> put_assoc(:user, attrs.user)
    |> put_assoc(:group, attrs.group)
  end
end
