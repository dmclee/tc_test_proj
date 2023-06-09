defmodule TestProj.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestProjWeb.Telemetry,
      # Start the Ecto repository
      TestProj.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestProj.PubSub},
      # Start Finch
      {Finch, name: TestProj.Finch},
      # Start the Endpoint (http/https)
      TestProjWeb.Endpoint
      # Start a worker by calling: TestProj.Worker.start_link(arg)
      # {TestProj.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestProj.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestProjWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
