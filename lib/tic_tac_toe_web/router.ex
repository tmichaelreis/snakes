defmodule TicTacToeWeb.Router do
  use TicTacToeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicTacToeWeb do
    pipe_through :browser

    get "/", PlayerController, :new
    post "/create", PlayerController, :create
    get "/waiting_room", WaitingRoomController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicTacToeWeb do
  #   pipe_through :api
  # end
end
