defmodule SnakesWeb.SoloGameLive do
  use Phoenix.LiveView

  def render(assigns) do
    SnakesWeb.SoloGameView.render("show.html", assigns)
  end

  def mount(%{username: username, user_id: user_id}, socket) do
    {:ok, assign(socket, user_id: user_id)}
  end
end
