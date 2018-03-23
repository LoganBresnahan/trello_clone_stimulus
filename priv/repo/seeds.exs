# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TrelloCloneStimulus.Repo.insert!(%TrelloCloneStimulus.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TrelloCloneStimulus.Repo
alias TrelloCloneStimulus.Accounts.User
alias TrelloCloneStimulus.GroupAccounts.Group
alias TrelloCloneStimulus.Projects.Board
alias TrelloCloneStimulus.Projects.Lane
alias TrelloCloneStimulus.Projects.Panel
alias TrelloCloneStimulus.UserGroup

user1 = Repo.insert!(
  User.changeset(
    %User{},
    %{
      alias: "carl",
      email: "email@email.com",
      name: "Logan",
      password: "password"
    }
  )
)

group1 = Repo.insert!(
  Group.changeset(
    %Group{},
    %{
      name: "Group 1"
    }
  )
)

Repo.insert!(
  UserGroup.changeset(
    %UserGroup{},
    %{
      user: user1,
      group: group1
    }
  )
)

board1 = Repo.insert!(
  Board.changeset(
    %Board{},
    %{
      name: "Board 1",
      group: group1
    }
  )
)

lane1 = Repo.insert!(
  Lane.changeset(
    %Lane{},
    %{
      title: "Lane 1",
      board: board1
    }
  )
)

lane2 = Repo.insert!(
  Lane.changeset(
    %Lane{},
    %{
      title: "Lane 2",
      board: board1
    }
  )
)

Repo.insert!(
  Panel.changeset(
    %Panel{},
    %{
      content: "Content 1",
      title: "Panel 1",
      lane: lane1
    }
  )
)

Repo.insert!(
  Panel.changeset(
    %Panel{},
    %{
      content: "Content 2",
      title: "Panel 2",
      lane: lane1
    }
  )
)

Repo.insert!(
  Panel.changeset(
    %Panel{},
    %{
      content: "Content 3",
      title: "Panel 3",
      lane: lane2
    }
  )
)

Repo.insert!(
  Panel.changeset(
    %Panel{},
    %{
      content: "Content 4",
      title: "Panel 4",
      lane: lane2
    }
  )
)

