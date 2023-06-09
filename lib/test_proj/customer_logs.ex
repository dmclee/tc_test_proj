defmodule TestProj.CustomerLogs do
  @moduledoc """
  The CustomerLogs context.
  """

  import Ecto.Query, warn: false
  alias TestProj.Repo

  alias TestProj.CustomerLogs.CustomerLog

  @valid_dish_type ["popular", "profitable"]
  @valid_customer_summary_type ["most_frequent"]

  @doc """
    Gets the number of visitors for a restaurant
    Returns `nil` when the restaurant does not exist

    ## Examples

        iex> get_visitor_count(restaurant_name)
        100

  """
  def get_visitor_count(name) do
    CustomerLog
    |> CustomerLog.for_restaurant(name)
    |> CustomerLog.select_visitor_count()
    |> CustomerLog.group_by_restaurant()
    |> Repo.all()
    |> List.first()
  end

  @doc """
    Gets the total profit for a restaurant
    Returns `nil` when the restaurant does not exist

    ## Examples

        iex> get_profit(restaurant_name)
        200.0

  """
  def get_profit(name) do
    CustomerLog
    |> CustomerLog.for_restaurant(name)
    |> CustomerLog.select_total_profit()
    |> CustomerLog.group_by_restaurant()
    |> Repo.all()
    |> List.first()
  end

  @doc """
    Gets all the restaurant names

    ## Examples

        iex> get_restaurant_names(restaurant_name)
        ["Name1", "Name2"...]

  """
  def get_restaurant_names() do
    CustomerLog
    |> CustomerLog.select_restaurant_names()
    |> CustomerLog.group_by_restaurant()
    |> Repo.all()
  end

  @doc """
    Gets status for all the restaurants
    Available types are:
      - popular
      - profitable

    ## Examples

        iex> get_dish_for_all_restaurants(type)
        %{
            "Name1" => "item",
            "Name2" => "item",
            ...
        }

  """
  def get_dish_for_all_restaurants(type) when type in @valid_dish_type do
    query = case type do
      "popular" -> CustomerLog.select_popular_dish_count(CustomerLog)
      "profitable" -> CustomerLog.select_profitable_dish(CustomerLog)
    end

    Enum.reduce(get_restaurant_names(), %{},
      fn restaurant, acc ->
        [item] =
          query
          |> CustomerLog.for_restaurant(restaurant)
          |> Repo.all()
        Map.put(acc, restaurant, item)
      end
    )
  end
  def get_dish_for_all_restaurants(_), do: %{}

  @doc """
    Gets the most frequent customers for the restaurants
    Available types are:
      - most_frequent

    ## Examples

        iex> get_customer_summary(type)
        %{
            "RName1" => "Name1",
            "RName2" => "Name2",
            ...
        }

  """
  def get_customer_summary(type) when type in @valid_customer_summary_type do
    Enum.reduce(get_restaurant_names(), %{},
      fn restaurant, acc ->
        [item] =
          CustomerLog
          |> CustomerLog.select_most_frequent_customer()
          |> CustomerLog.for_restaurant(restaurant)
          |> Repo.all()
        Map.put(acc, restaurant, item)
      end
    )
  end
  def get_customer_summary(_), do: %{}

  @doc """
    Gets the customer name who matches the type
    Available types:
      - most_visited

    ## Examples

        iex> get_customer("most_visited")
        "Name"

  """
  def get_customer("most_visited") do
    CustomerLog
    |> CustomerLog.select_most_frequent_customer()
    |> Repo.all()
    |> List.first()
  end
  def get_customer(_), do: nil

end