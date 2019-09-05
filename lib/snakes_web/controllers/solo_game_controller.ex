defmodule SnakesWeb.SoloGameController do
  use SnakesWeb, :controller
  alias Phoenix.LiveView

  def show(conn, _params) do
    username = get_session(conn, :username)
    user_id = get_session(conn, :user_id)

    conn
    |> assign(:username, username)
    |> LiveView.Controller.live_render(SnakesWeb.SoloGameLive,
      session: %{username: username, user_id: user_id}
    )
  end
end
