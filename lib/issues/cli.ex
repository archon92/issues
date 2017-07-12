defmodule Issues.CLI do
  @moduledoc """
    module interfaces with command line and parses arguments using option parser
  """
  def run(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean])
    
    case parse do
      {[help: true], _, _} 
      -> :help
      { _, [user,project,count], _}
      -> {user,project,count}
    end
  end

end

