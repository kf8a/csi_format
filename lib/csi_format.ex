defmodule CsiFormat do
  @moduledoc """
  Documentation for `CsiFormat`.
  """

  @doc """
  parse data from a TOA5 file
  """
  def parse_toa5(data) do
    CsiFormat.Toa5.parse(data)
  end
end
