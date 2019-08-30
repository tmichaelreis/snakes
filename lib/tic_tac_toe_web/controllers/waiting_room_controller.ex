defmodule TicTacToeWeb.WaitingRoomController do
  use TicTacToeWeb, :controller
  alias Phoenix.LiveView
  alias TicTacToeWeb.WaitingRoomLive

  def index(conn, _params) do
    username = get_session(conn, :username)

    LiveView.Controller.live_render(
      conn,
      WaitingRoomLive,
      session: %{username: username}
    )
  end
end
