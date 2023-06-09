defmodule TestProj.CustomerLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestProj.CustomerLogs` context.
  """

  @doc """
  Generate a customer_log.
  """
  def customer_log_fixture(attrs \\ %{}) do
    {:ok, customer_log} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        food_cost: 120.5,
        food_names: "some food_names",
        restaurant_names: "some restaurant_names"
      })
      |> TestProj.CustomerLogs.create_customer_log()

    customer_log
  end
end
