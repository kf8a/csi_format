defmodule CsiFormat.Toa5 do
  @moduledoc """
  TOA5 format parser
  """

  alias NimbleCSV.RFC4180, as: CSV

  def parse(raw_data) do
    data = parse_raw_data(raw_data)

    {header, values} = Enum.split(data, 4)

    data =
      values
      |> Enum.map(&to_values/1)
      |> Enum.map(fn x -> to_map(Enum.at(header, 1), x) end)

    {:ok, data}
  end

  defp parse_raw_data(raw_data) do
    raw_data
    |> String.replace(~s{""NAN""}, "NAN")
    |> CSV.parse_string(skip_headers: false)
    |> Enum.drop(-1)
  end

  defp to_map(header, values) do
    Enum.zip(header, values)
    |> Enum.into(%{})
  end

  defp to_values(data) do
    Enum.map(data, &parse_string/1)
  end

  defp parse_string(str) do
    cond do
      # Integer
      String.match?(str, ~r/^-?\d+$/) ->
        String.to_integer(str)

      # Float
      String.match?(str, ~r/^-?\d+\.\d+$/) ->
        String.to_float(str)

      # Timestamp (ISO 8601 format)
      String.match?(str, ~r/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(\.\d+)?$/) ->
        NaiveDateTime.from_iso8601!(str)

      true ->
        raise ArgumentError, "Invalid input string: #{str}"
    end
  end
end
