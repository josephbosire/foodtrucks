defmodule FoodTruckApi.CsvUtil do
  alias NimbleCSV.RFC4180, as: CSV

  def load_food_truck_data_from_csv(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Stream.transform(nil, fn
      headers, nil -> {[], headers}
      row, headers -> {[Enum.zip(headers, row) |> Map.new() |> parse_truck_info()], headers}
    end)
  end

  @spec parse_menu_items(String.t()) :: [String.t()]
  defp parse_menu_items(menu_items) do
    menu_items
    |> String.downcase()
    |> String.split(":")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
  end

  @spec parse_facility_type(String.t()) :: String.t()
  defp parse_facility_type(facility_type) do
    facility_type
    |> String.downcase()
    |> String.trim()
  end

  @spec parse_status(String.t()) :: String.t()
  defp parse_status(status) do
    status
    |> String.downcase()
    |> String.trim()
  end

  defp parse_truck_info(truck) do
    %{
      name: truck["Applicant"],
      address: truck["LocationDescription"],
      block: truck["block"],
      lot: truck["lot"],
      type: parse_facility_type(truck["FacilityType"]),
      status: parse_status(truck["Status"]),
      location_info: parse_location_info(truck),
      menu_items: parse_menu_items(truck["FoodItems"])
    }
  end

  @spec parse_location_info(map()) :: map() | nil
  defp parse_location_info(truck) do
    if truck["Latitude"] != "" && truck["Longitude"] != "" do
      %{
        latitude: Decimal.new(truck["Latitude"]),
        longitude: Decimal.new(truck["Longitude"])
      }
    else
      nil
    end
  end
end
