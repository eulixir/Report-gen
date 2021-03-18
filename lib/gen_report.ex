defmodule GenReport do
  alias GenReport.Parser

  @file_name "gen_report.csv"

  @names [
    "daniele",
    "mayk",
    "giuliano",
    "cleiton",
    "jakeliny",
    "joseph",
    "diego",
    "rafael",
    "vinicius",
    "danilo"
  ]

  def build() do
    @file_name
    |> Parser.parse_file()
    |> Enum.reduce(hours_acc(), fn row, acc ->
      get_hours(row, acc)
    end)
  end

  defp hours_acc(), do: %{"all_hours" => %{}} |> Map.put("all_hours", acc_name_map_gen(0))

  defp acc_name_map_gen(value), do: Enum.into(@names, %{}, &{&1, value})

  defp get_hours([name, hours, _day, _month, _year], %{
         "all_hours" => all_hours
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    %{
      "all_hours" => all_hours
    }
  end
end
