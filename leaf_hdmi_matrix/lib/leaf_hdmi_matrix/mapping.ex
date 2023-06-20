defmodule LeafHdmiMatrix.Mapping do
  require Logger

  defstruct [
    :inputs,
    :outputs
  ]

  defp output_from_name(%LeafHdmiMatrix.Mapping{outputs: outputs}, name) do
    find_mapping(outputs, name)
  end

  def output_from_name!(%LeafHdmiMatrix.Mapping{} = mapping, name) do
    case output_from_name(mapping, name) do
      nil -> raise "No output mapping for #{name}"
      num -> num
    end
  end

  defp input_from_name(%LeafHdmiMatrix.Mapping{inputs: inputs}, name) do
    find_mapping(inputs, name)
  end

  def input_from_name!(%LeafHdmiMatrix.Mapping{} = mapping, name) do
    case input_from_name(mapping, name) do
      nil -> raise "No input mapping for #{name}"
      num -> num
    end
  end

  # Fallback to number
  def input_to_name(%LeafHdmiMatrix.Mapping{inputs: inputs}, input),
    do: Map.get(inputs, input, input)

  # Fallback to number
  def output_to_name(%LeafHdmiMatrix.Mapping{outputs: outputs}, output),
    do: Map.get(outputs, output, output)

  defp find_mapping(nil, _), do: nil

  defp find_mapping(mapping, name) do
    case Enum.find(mapping, fn {_k, v} -> v == name end) do
      {n, _} -> n
      rest -> rest
    end
  end
end
