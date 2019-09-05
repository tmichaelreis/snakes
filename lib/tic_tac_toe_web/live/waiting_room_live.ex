defmodule TicTacToeWeb.WaitingRoomLive do
  use Phoenix.LiveView
  alias TicTacToeWeb.Presence

  def render(assigns) do
    TicTacToeWeb.WaitingRoomView.render("show.html", assigns)
  end

  def mount(%{username: username, user_id: user_id}, socket) do
    Presence.track(
      self(),
      "players",
      user_id,
      %{name: username, high_score: :rand.uniform(1000), wants_to_play_id: nil}
    )

    TicTacToeWeb.Endpoint.subscribe("players")

    {:ok,
     assign(socket,
       user_id: user_id,
       players: list_players(user_id)
     )}
  end

  def handle_info(
        %{event: "presence_diff", payload: state},
        socket = %{assigns: %{user_id: user_id}}
      ) do
    {:noreply, assign(socket, user_id: user_id, players: list_players(user_id))}
  end

  def handle_event("request-game", %{"opponent" => opponent_id}, socket) do
    # TODO: update presence with wants_to_play_id
    # TODO: figure out player accept back and forth
    {:noreply, socket}
  end

  # TODO: move the list_players logic to `tic_tac_toe` context?

  defp list_players() do
    Presence.list("players")
    |> get_player_info()
  end

  defp list_players(user_id = user_id) do
    Presence.list("players")
    |> Enum.reject(fn {player_id, _metas} ->
      player_id == user_id
    end)
    |> get_player_info
  end

  defp get_player_info(presence_list) do
    presence_list
    |> Enum.map(fn {user_id, data} ->
      %{user_id: user_id, data: data[:metas] |> List.first()}
    end)
  end
end
