defmodule LeafHdmiMatrix do
  require Logger

  alias LeafHdmiMatrix.Protocol
  alias LeafHdmiMatrix.Protocol.Status
  alias LeafHdmiMatrix.Mapping

  defstruct [
    :tty,
    :mapping
  ]

  # Convenience during dev
  def connect(),
    do:
      connect("/dev/tty.usbserial-1420", %LeafHdmiMatrix.Mapping{
        inputs: %{
          1 => "Laptop",
          2 => "Chromecast",
          3 => "PC"
        },
        outputs: %{
          1 => "TV",
          4 => "Monitor"
        }
      })

  def connect(tty, %LeafHdmiMatrix.Mapping{} = mapping) do
    {:ok, pid} = Circuits.UART.start_link()

    :ok =
      Circuits.UART.open(pid, tty,
        speed: 9600,
        active: false,
        framing: LeafHdmiMatrix.Protocol.Framing
      )

    {:ok,
     %LeafHdmiMatrix{
       tty: pid,
       mapping: mapping
     }}
  end

  def query_status(%LeafHdmiMatrix{mapping: mapping} = state, output) when is_binary(output) do
    num = Mapping.output_from_name!(mapping, output)
    query_status(state, num)
  end

  def query_status(%LeafHdmiMatrix{tty: tty}, output) do
    req = %Status{output: output} |> Protocol.status_request()
    debug(:send, req)
    :ok = Circuits.UART.write(tty, req)

    {:ok, resp} = Circuits.UART.read(tty)
    debug(:recv, resp)
    Protocol.status_response(resp)
  end

  def query_status(%LeafHdmiMatrix{} = state) do
    1..8
    |> Enum.map(fn o -> query_status(state, o) end)
  end

  def set_output(%LeafHdmiMatrix{tty: tty}, %Status{} = status) do
    req = Protocol.set_request(status)
    debug(:send, req)
    :ok = Circuits.UART.write(tty, req)

    {:ok, resp} = Circuits.UART.read(tty)
    debug(:recv, resp)
    Protocol.set_response(resp)
  end

  defp debug(type, msg) do
    binary = inspect(msg)
    Logger.debug("#{type}: #{binary}")
  end
end
