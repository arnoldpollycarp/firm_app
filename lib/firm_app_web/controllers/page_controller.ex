defmodule FirmAppWeb.PageController do
  use FirmAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
