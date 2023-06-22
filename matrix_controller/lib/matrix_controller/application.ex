defmodule MatrixController.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {NodeJS.Supervisor, [path: LiveSvelte.SSR.server_path(), pool_size: 4]},
      # Start the Telemetry supervisor
      MatrixControllerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MatrixController.PubSub},
      # Start the Endpoint (http/https)
      MatrixControllerWeb.Endpoint
      # Start a worker by calling: MatrixController.Worker.start_link(arg)
      # {MatrixController.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MatrixController.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MatrixControllerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
