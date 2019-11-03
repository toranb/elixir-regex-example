defmodule RegexxWeb.PageController do
  use RegexxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
