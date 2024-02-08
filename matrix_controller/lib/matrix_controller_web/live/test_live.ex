defmodule MatrixControllerWeb.TestLive do
  use MatrixControllerWeb, :live_view
  use LiveSvelte.Components

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    inputs = %{
      0 => "Chromecast",
      1 => "PC"
    }

    outputs = %{
      10 => "TV",
      11 => "Monitor",
      12 => "Projector",
      13 => "Speakers"
    }

    connections = [
      [0, 10],
      [0, 13],
      [1, 11]
    ]

    socket =
      socket
      |> assign(:inputs, inputs)
      |> assign(:outputs, outputs)
      |> assign(:connections, connections)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.SelectBoxes inputs={@inputs} outputs={@outputs} connections={@connections} />
    """
  end
end
