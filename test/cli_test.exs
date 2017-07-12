defmodule CliTest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [parse_args: 1]

  test "the truth" do
    assert 1 + 1 == 2
  end
  
  test ":help returns help" do
    assert parse_args(["--help","random"]) == :help
  end
end
