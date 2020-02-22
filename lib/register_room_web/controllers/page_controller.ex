defmodule RegisterRoomWeb.PageController do
  use RegisterRoomWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
