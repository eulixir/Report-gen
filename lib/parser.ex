defmodule ReportGen.Parser do

  def parse_file(filename) do
    filename
    |> File.stream!()

  end

end
