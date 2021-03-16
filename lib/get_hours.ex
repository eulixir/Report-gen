defmodule GenReport.GetHours do
  def get_hours([name, hours, _day, _month, _year], %{
        "all_hours" => all_hours
      }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    %{
      "all_hours" => all_hours
    }
  end
end
