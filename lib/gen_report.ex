defmodule GenReport do
  alias GenReport.{Parser, GetHours}

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

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @filename "gen_report.csv"

  def build() do
    @filename
    |> Parser.parse_file()
    |> Enum.reduce(hours_acc(), fn row, acc ->
      GetHours.get_hours(row, acc)
    end)
  end

  defp hours_acc do
    month_list = Enum.into(@months, %{}, &{&1, 0})
    year_list = Enum.into(2016..2020, %{}, &{&1, 0})

    %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}}
    |> Map.put("all_hours", acc_id_map_gen(0))
    |> Map.put("hours_per_month", acc_id_map_gen(month_list))
    |> Map.put("hours_per_year", acc_id_map_gen(year_list))
  end

  defp acc_id_map_gen(value), do: Enum.into(@names, %{}, &{&1, value})
end
