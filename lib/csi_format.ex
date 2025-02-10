defmodule CsiFormat do
  @moduledoc """
  A module to parse data from a Campbell Scientific data file. This module currently supports TOA5 files.
  """

  @doc """
  parse well formed data from a TOA5 file,

  ## Examples

      iex> CsiFormat.parse_toa5(File.read!("path/to/file"))
      {:ok, [%Map{...}]}


  Warning: It does no validation to the data file but make s best effort to parse the data.
  """
  def parse_toa5(data) do
    CsiFormat.Toa5.parse(data)
  end
end
