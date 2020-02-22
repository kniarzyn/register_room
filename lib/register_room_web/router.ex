defmodule RegisterRoomWeb.Router do
  use RegisterRoomWeb, :router

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

  scope "/", RegisterRoomWeb do
    pipe_through :browser

    resources("/vouchers", VoucherController, except: [:delete])
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RegisterRoomWeb do
  #   pipe_through :api
  # end
end
