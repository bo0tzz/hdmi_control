defmodule MatrixControllerWeb.TestLive do
  use MatrixControllerWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :target, "LiveView")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.HelloWorld target={@target} />
    """
  end

  def handle_event("set_target", %{"target" => target}, socket) do
    Logger.info("Setting target to #{target}")
    {:noreply, assign(socket, :target, target)}
  end
end
