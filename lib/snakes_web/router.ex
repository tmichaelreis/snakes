defmodule SnakesWeb.Router do
  use SnakesWeb, :router

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

  scope "/", SnakesWeb do
    pipe_through :browser

    get "/", PlayerController, :new
    post "/create", PlayerController, :create
    get "/waiting_room", WaitingRoomController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SnakesWeb do
  #   pipe_through :api
  # end
end
