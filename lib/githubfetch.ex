defmodule Issues.GithubIssues do
  @moduledoc """
  Module to fetch github issues
  """

  @github_url Application.get_env(:issues, :github_url)


  def issues_url(user,project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def fetch(user,project) do
    issues_url(user,project)
      |> HTTPoison.get
      |> handle_response
  end

  def handle_response({:ok, %{status_code: 200,body: body}}), do: {:ok, :jsx.decode(body)}
  def handle_response({:ok, %{status_code: _,body: body}}), do: {:error, :jsx.decode(body)}
    
end
