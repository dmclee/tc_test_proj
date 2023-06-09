defmodule TestProjWeb.Router do
  use TestProjWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TestProjWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TestProjWeb do
    pipe_through :api

    get "/restaurant/:name/visitor_count", CustomerLogController, :get_visitor_count
    get "/restaurant/:name/profit", CustomerLogController, :get_profit
    get "/restaurants/dish/:type", CustomerLogController, :get_dish_summary
    get "/restaurants/customer/:type", CustomerLogController, :get_customer_summary
    get "/customer/:type", CustomerLogController, :get_customer_type
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestProjWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:test_proj, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TestProjWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
