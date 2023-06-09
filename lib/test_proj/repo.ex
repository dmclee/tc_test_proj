defmodule TestProj.Repo do
  use Ecto.Repo,
    otp_app: :test_proj,
    adapter: Ecto.Adapters.MyXQL
end
