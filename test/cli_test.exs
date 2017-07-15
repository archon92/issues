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

  test "user project count returns count" do
    assert parse_args(["a","p",6]) == {"a","p",6}
  end

  test "user project returns default count" do
    assert parse_args(["user","project"]) == {"user","project",4}
  end

  test "random args return help" do
    assert parse_args(["asasd"]) == :help
  end
end
