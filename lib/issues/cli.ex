defmodule Issues.CLI do
  @moduledoc """
    module interfaces with command line and parses arguments using option parser
  """
  @default_count 4

  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean])
    
    case parse do
      {[help: true], _, _} 
      -> :help
      { _, [user,project,count], _}
      -> {user,project,count}
      { _, [user,project], _ }
      -> {user,project,@default_count}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
      Usage issues <user> <project> [count | #{@default_count}]
    """                                                        
    System.halt(0)
  end

  def process({user,project,_count}) do
    Issues.GithubIssues.fetch(user,project)
      |> decode_response
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, body}) do
    {_, message} = List.keyfind(body, "message" , 0)
    IO.puts "ERROR #{message}"
    System.halt(2)
  end

  def convert_list_into_maps(list) do
    list
    |> Enum.map(&Enum.into(&1,Map.new))
  end

end

