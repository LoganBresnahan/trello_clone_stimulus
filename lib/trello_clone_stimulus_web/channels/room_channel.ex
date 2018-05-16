defmodule TrelloCloneStimulusWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:"<>_private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  # def handle_in("new_msg", %{"body" => body}, socket) do
  #   broadcast! socket, "new_msg", %{body: body}
  #   {:noreply, socket}
  # end
  def handle_in("make_editable", %{"body" => body, "user" => user}, socket) do
    broadcast! socket, "make_editable", %{body: body, user: user}
    {:noreply, socket}
  end
  def handle_in("set_content", %{"body" => body, "elementId" => elementId, "user" => user}, socket) do
    broadcast! socket, "set_content", %{body: body, elementId: elementId, user: user}
    {:noreply, socket}
  end
  def handle_in("unblur_editable", %{"body" => body, "user" => user}, socket) do
    broadcast! socket, "unblur_editable", %{body: body, user: user}
    {:noreply, socket}
  end
  def handle_in("change_color", %{"body" => body, "elementId" => elementId, "user" => user}, socket) do
    broadcast! socket, "change_color", %{body: body, elementId: elementId, user: user}
    {:noreply, socket}
  end
  def handle_in("blur_sort", %{"body" => body, "user" => user}, socket) do
    broadcast! socket, "blur_sort", %{body: body, user: user}
    {:noreply, socket}
  end
  def handle_in("unblur_sort", %{"body" => body = %{"to_children" => to_children}, "user" => user}, socket) do
    
    to_children = Enum.map(to_children, fn(id) ->
      "container-" <> id
    end)

    body = Map.update!(body, "to_children", &(&1 = to_children))

    broadcast! socket, "unblur_sort", %{body: body, user: user}
    {:noreply, socket}
  end
end
