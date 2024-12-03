# CsiFormat

A tiny library to parse TOA5 files from Campbell Scientific dataloggers.

[Reference](https://help.campbellsci.com/loggernet-manual/ln_manual/campbell_scientific_file_formats/toa5.htm?TocPath=Campbell%20Scientific%20File%20Formats%7CComputer%20File%20Data%20Formats%7CTOA5%7C_____0)

## Usage

```elixir
iex> File.read(toa5_filename) |> CsiFormat.parse_toa5()
{:ok, [%{...}, ...]}
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `csi_format` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:csi_format, "~> 0.1.0"}
  ]
end
```

