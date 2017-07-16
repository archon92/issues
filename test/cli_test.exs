defmodule CliTest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [parse_args: 1, convert_list_into_maps: 1, sort_into_ascending_order: 1]

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


  test"data is sorted with asc created_at" do
     result = sort_into_ascending_order(fake_created_at(["b","c","a"]))
    issues = for issue <-result, do: issue["created_at"]
    assert issues == ~w(a b c)

  end

  defp fake_created_at(list) do
    data = for item <- list,
           do: [{"created_at", item},{"other_data", "random"}]
    IO.puts inspect data
    convert_list_into_maps data

  end
end
