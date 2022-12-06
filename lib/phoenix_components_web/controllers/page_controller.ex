defmodule PhoenixComponentsWeb.PageController do
  use PhoenixComponentsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
