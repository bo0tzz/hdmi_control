defmodule MatrixControllerWeb.TestLive do
  use MatrixControllerWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.Matrix />
    """
  end
end
