defmodule MoviedbWeb.Router do
  use MoviedbWeb, :router

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

  scope "/", MoviedbWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug,
    schema: MoviedbWeb.Schema,
    json_codec: Jason

  if Mix.env() == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: MoviedbWeb.Schema,
      json_codec: Jason,
      interface: :playground
  end

  # Other scopes may use custom stacks.
  # scope "/api", MoviedbWeb do
  #   pipe_through :api
  # end
end
