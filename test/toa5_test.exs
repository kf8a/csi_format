defmodule Toa5Test do
  use ExUnit.Case
  doctest CsiFormat.Toa5

  test "parses TOA5 data" do
    data = File.read!("test/fixtures/toa5.dat")

    assert {:ok, records} = CsiFormat.Toa5.parse(data)
    assert Enum.count(records) == 6

    first = Enum.at(records, 0)
    assert first["batt_volt_Min"] == 12.62
  end
end
