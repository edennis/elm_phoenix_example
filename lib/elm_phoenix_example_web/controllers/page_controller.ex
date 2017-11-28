defmodule ElmPhoenixExampleWeb.PageController do
  use ElmPhoenixExampleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
