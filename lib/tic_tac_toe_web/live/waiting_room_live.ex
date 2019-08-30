defmodule TicTacToeWeb.WaitingRoomLive do
  use Phoenix.LiveView

  def render(assigns) do
    TicTacToeWeb.WaitingRoomView.render("show.html", assigns)
  end

  def mount(%{username: username}, socket) do
    {:ok,
     assign(socket,
       username: username
     )}
  end
end
