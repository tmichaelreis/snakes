defmodule SnakesWeb.WaitingRoomController do
  use SnakesWeb, :controller
  alias Phoenix.LiveView
  alias SnakesWeb.WaitingRoomLive

  def index(conn, _params) do
    username = get_session(conn, :username)
    user_id = get_session(conn, :user_id)

    # TODO:
    # Render a LiveView layout (which renders a liveview template)
    # instead of the template itself.
    # Assign username information etc. in layout
    # Pass this info to templates?

    conn
    |> assign(:username, username)
    |> LiveView.Controller.live_render(WaitingRoomLive,
      session: %{username: username, user_id: user_id}
    )
  end
end
