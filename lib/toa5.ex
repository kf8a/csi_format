defmodule CsiFormat.Toa5 do
  @moduledoc """
  TOA5 format parser
  """

  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  Parse TOA5 data. This function expects a string containing the raw data from a TOA5 file, and returns
  a list of maps. Each map represents a row of data, with the keys being the column names and the values
  being the data for that row.

  ## Example

       iex> parse("TIMESTAMP,RECORD,Value1,Value2\n2019-01-01 00:00:00,1,1.0,2.0\n2019-01-01 00:00:01,2,2.0,3.0")
       {:ok, [%{"TIMESTAMP" => ~U[2019-01-01 00:00:00Z], "RECORD" => 1, "Value1" => 1.0, "Value2" => 2.0},
         %{"TIMESTAMP" => ~U[2019-01-01 00:00:01Z], "RECORD" => 2, "Value1" => 2.0, "Value2" => 3.0}]}


  ### Warning

  no validation is done on the shape of the input data. Invalid data will likely result in returning wrong results.

  """
  @spec parse(String.t()) :: {:ok, [map()]}
  def parse(raw_data) do
    data = parse_raw_data(raw_data)

    {header, values} = Enum.split(data, 4)

    data =
      values
      |> Enum.map(&to_values/1)
      |> Enum.map(fn x -> to_map(Enum.at(header, 1), x) end)

    case data do
      [] -> {:error, "No data found"}
      _ -> {:ok, data}
    end
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
