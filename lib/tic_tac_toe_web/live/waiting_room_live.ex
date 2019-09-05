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
       players: list_players(username)
     )}
  end

  def handle_info(
        %{event: "presence_diff", payload: state},
        socket = %{assigns: %{username: username}}
      ) do
    {:noreply, assign(socket, username: username, players: list_players(username))}
  end

  # TODO: move the list_players logic to `tic_tac_toe` context?

  defp list_players() do
    Presence.list("players")
    |> get_player_info()
  end

  defp list_players(username = username) do
    Presence.list("players")
    |> Enum.reject(fn {player_name, _metas} ->
      player_name == username
    end)
    |> get_player_info
  end

  defp get_player_info(presence_list) do
    presence_list
    |> Enum.map(fn {username, metas} ->
      username
    end)
  end
end
