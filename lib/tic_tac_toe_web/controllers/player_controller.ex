defmodule TicTacToeWeb.PlayerController do
  use TicTacToeWeb, :controller
  require Logger

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    # Establish LiveView connection & do some presence stuff
    text(conn, "Hi #{name}. This will render an interactive game queue")
  end
end
