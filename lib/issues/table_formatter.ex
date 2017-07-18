defmodule Issues.TableFormatter do
  import Enum

  def print_table_for_columns(rows,headers) do
    column_data = split_data(rows,headers)
    column_widths = widths(column_data)
    format = format_for(column_widths)
    inspect format
  end


  def split_data(rows,headers) do
    for header <- headers do
      for row <- rows do
         printable(row[header])
      end
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str) , do: to_string(str)

  def widths(column_data) do
    for column <- column_data do
      column
      |> Enum.map(&String.length/1)
      |> Enum.max
    end
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths , " | " , fn width -> "~-#{width}s" end) <> "~n" 
  end
end
