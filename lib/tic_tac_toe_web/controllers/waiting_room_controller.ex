defmodule TicTacToeWeb.WaitingRoomController do
  use TicTacToeWeb, :controller
  alias Phoenix.LiveView
  alias TicTacToeWeb.WaitingRoomLive

  def index(conn, _params) do
    username = get_session(conn, :username)

    # TODO:
    # Render a LiveView layout (which renders a liveview template)
    # instead of the template itself.
    # Assign username information etc. in layout
    # Pass this info to templates?

    LiveView.Controller.live_render(
      conn,
      WaitingRoomLive,
      session: %{username: username}
    )
  end
end
