defmodule GenReport do
  alias GenReport.Parser

  @file_name "gen_report.csv"

  def build() do
    @file_name
    |> Parser.parse_file()
  end
end
