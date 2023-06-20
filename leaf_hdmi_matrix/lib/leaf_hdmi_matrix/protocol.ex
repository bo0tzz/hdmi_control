defmodule LeafHdmiMatrix.Protocol do
  alias LeafHdmiMatrix.Protocol.Status

  def status_request(%Status{output: output}) when output >= 1 and output <= 8,
    # Outputs are 0-indexed on the protocol
    do: <<52, 0, output - 1>>

  def status_response(<<53, input, output>>),
    do: %Status{
      input: input,
      # Outputs are 0-indexed on the protocol
      output: output + 1
    }

  def set_request(%Status{input: input, output: output}), do: <<72, input, output - 1>>
  def set_response(<<72, input, output>>), do: %Status{input: input, output: output + 1}
end
