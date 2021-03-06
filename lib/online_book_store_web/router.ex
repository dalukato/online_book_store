defmodule OnlineBookStoreWeb.Router do
  use OnlineBookStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", OnlineBookStoreWeb do
    pipe_through :api
    get "/authors", AuthorController, :index
    get "/authors/:id", AuthorController, :show
    post "/authors/add", AuthorController, :create

    get "/categories", CategoryController, :index
    get "/categories/:id", CategoryController, :show
    post "/categories/add", CategoryController, :create
    post "/categories/delete", CategoryController, :delete

    get "/books", BookController, :index
    get "/books/:id", BookController, :show
    post "/books/add", BookController, :create
    post "/books/update", BookController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: OnlineBookStoreWeb.Telemetry
    end
  end
end
