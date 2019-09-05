defmodule TicTacToeWeb.PlayerController do
  use TicTacToeWeb, :controller
  require Logger

  def new(conn, _params) do
    case get_session(conn, :user_id) do
      nil ->
        render(conn, "new.html")

      _ ->
        redirect(conn, to: "/waiting_room")
    end
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    conn
    |> put_session(:username, name)
    |> put_session(:user_id, generate_user_id)
    |> redirect(to: "/waiting_room")
  end

  defp generate_user_id do
    UUID.uuid1()
  end
end
