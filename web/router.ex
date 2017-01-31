defmodule MagicLink.Router do
  use MagicLink.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MagicLink do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  
    get "/signin/:token", SessionController, :show, as: :signin
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MagicLink do
  #   pipe_through :api
  # end
end
