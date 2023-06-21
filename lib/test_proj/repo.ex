defmodule TestProj.Repo do
  use Ecto.Repo,
    otp_app: :test_proj,
    adapter: Ecto.Adapters.MyXQL

  def init(_, config) do
    config = config
      |> Keyword.put(:username, System.get_env("SQL_USER"))
      |> Keyword.put(:password, System.get_env("SQL_PASSWORD"))
      |> Keyword.put(:database, System.get_env("SQL_DATABASE"))
      |> Keyword.put(:hostname, System.get_env("SQL_HOST"))
      |> Keyword.put(:port, System.get_env("SQL_PORT") |> String.to_integer)
    {:ok, config}
  end
end
