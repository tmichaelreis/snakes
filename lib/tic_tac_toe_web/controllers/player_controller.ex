defmodule TicTacToeWeb.PlayerController do
  use TicTacToeWeb, :controller
  require Logger

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    conn
    |> put_session(:username, name)
    |> redirect(to: "/waiting_room")
  end
end
