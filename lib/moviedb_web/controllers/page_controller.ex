defmodule MoviedbWeb.PageController do
  use MoviedbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
