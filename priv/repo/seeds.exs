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

################################################ Small Example
# (1..3) |> Enum.each(fn(n) ->
#   Repo.insert!(
#     Board.changeset(
#       %Board{},
#       %{
#         name: "Board #{n}",
#         group: group1,
#         order: n
#       }
#     )
#   )
# end)

# (1..6) |> Enum.each(fn(n) ->
#   Repo.insert!(
#     Lane.changeset(
#       %Lane{},
#       %{
#         title: "Lane #{n}",
#         board: (if (x = rem(n, 3)) == 0, do: Repo.get!(Board, 3), else: Repo.get!(Board, x)),
#         order: n
#       }
#     )
#   )
# end)

# (1..6) |> Enum.each(fn(n) ->
#   Repo.insert!(
#     Panel.changeset(
#       %Panel{},
#       %{
#         content: "Content #{n}",
#         title: "Panel #{n}",
#         lane: Repo.get!(Lane, n),
#         order: n
#       }
#     )
#   )
# end)

# (1..6) |> Enum.each(fn(n) ->
#   Repo.insert!(
#     Panel.changeset(
#       %Panel{},
#       %{
#         content: "Content #{n + 6}",
#         title: "Panel #{n + 6}",
#         lane: Repo.get!(Lane, n),
#         order: (n + 1)
#       }
#     )
#   )
# end)

########################################## Big Example
(1..50) |> Enum.each(fn(n) ->
  Repo.insert!(
    Board.changeset(
      %Board{},
      %{
        name: "Board #{n}",
        group: group1,
        order: n
      }
    )
  )
end)

(1..1000) |> Enum.each(fn(n) ->
  Repo.insert!(
    Lane.changeset(
      %Lane{},
      %{
        title: "Lane #{n}",
        board: (if (x = rem(n, 50)) == 0, do: Repo.get!(Board, 50), else: Repo.get!(Board, x)),
        order: n
      }
    )
  )
end)

(1..1000) |> Enum.each(fn(n) ->
  Repo.insert!(
    Panel.changeset(
      %Panel{},
      %{
        content: "Content #{n}",
        title: "Panel #{n}",
        lane: Repo.get!(Lane, n),
        order: n
      }
    )
  )
end)

(1..1000) |> Enum.each(fn(n) ->
  Repo.insert!(
    Panel.changeset(
      %Panel{},
      %{
        content: "Content #{n + 1000}",
        title: "Panel #{n + 1000}",
        lane: Repo.get!(Lane, n),
        order: (n + 1)
      }
    )
  )
end)