defmodule GenReport do
  alias GenReport.{Parser, GetHours}

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
      GetHours.get_hours(row, acc)
    end)
  end

  defp hours_acc do
    %{"all_hours" => %{}}
    |> Map.put("all_hours", acc_name_map_gen(0))
  end

  defp acc_name_map_gen(value), do: Enum.into(@names, %{}, &{&1, value})
end
