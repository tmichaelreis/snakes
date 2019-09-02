defmodule TicTacToeWeb.WaitingRoomLive do
  use Phoenix.LiveView
  alias TicTacToeWeb.Presence

  def render(assigns) do
    TicTacToeWeb.WaitingRoomView.render("show.html", assigns)
  end

  def mount(%{username: username}, socket) do
    Presence.track(
      self(),
      "players",
      username,
      %{wants_to_play_id: nil}
    )

    TicTacToeWeb.Endpoint.subscribe("players")

    {:ok,
     assign(socket,
       username: username,
       players: list_players()
     )}
  end

  def handle_info(
        %{event: "presence_diff", payload: state},
        socket = %{assigns: %{players: players}}
      ) do
    {:noreply, assign(socket, players: list_players())}
  end

  defp list_players() do
    Presence.list("players")
    |> Enum.map(fn {username, metas} ->
      username
    end)
  end
end
