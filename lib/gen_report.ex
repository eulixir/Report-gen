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


  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(hours_acc(), fn row, acc ->
      GetHours.get_hours(row, acc)
    end)
  end

  def build_from_many(filename) do
   result =
     filename
    |> Task.async_stream(&build/1)
    |> Enum.reduce(hours_acc(), fn {:ok, report}, acc ->
      sum_reports(report, acc)
    end)

    {:ok, result}
  end

  defp sum_reports(%{
    "all_hours" => all_hours1,
    "hours_per_month" => hours_per_month1,
    "hours_per_year" => hours_per_year1
    },
    %{
      "all_hours" => all_hours2,
      "hours_per_month" => hours_per_month2,
      "hours_per_year" => hours_per_year2
  }) do
      all_hours = merge_map(all_hours1, all_hours2)
      hours_per_month = merge_map(hours_per_month1, hours_per_month2)
      hours_per_year = merge_map(hours_per_year1, hours_per_year2)

      build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_map(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2  end)
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

  defp build_report(all_hours,hours_per_month, hours_per_year), do: %{
    "all_hours" => all_hours,
    "hours_per_month" => hours_per_month,
    "hours_per_year" => hours_per_year
  }
end
