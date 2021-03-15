defmodule ReportGen do
  alias ReportGen.Parser

  @filename "gen_report.csv"

  def build() do
    @filename
    |> Parser.parse_file()
  end
end
