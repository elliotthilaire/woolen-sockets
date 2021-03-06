defmodule WoolenSockets.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(WoolenSocketsWeb.Endpoint, []),
      # Start your own worker by calling: WoolenSockets.Worker.start_link(arg1, arg2, arg3)
      # worker(WoolenSockets.Worker, [arg1, arg2, arg3]),
      worker(WoolenSockets.GameState, []),
      worker(WoolenSockets.WorldBroadcaster, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WoolenSockets.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WoolenSocketsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
