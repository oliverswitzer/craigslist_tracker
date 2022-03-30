defmodule CraigslistTrackerWeb.PageController do
  use CraigslistTrackerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
