defmodule PhoenixComponentsWeb.Router do
  use PhoenixComponentsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixComponentsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixComponentsWeb do
    pipe_through :browser

    live "/", LiveViewCanvas
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixComponentsWeb do
  #   pipe_through :api
  # end
end
