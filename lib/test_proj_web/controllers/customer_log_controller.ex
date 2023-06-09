defmodule TestProjWeb.CustomerLogController do
  use TestProjWeb, :controller

  alias TestProj.CustomerLogs
  alias TestProj.CustomerLogs.CustomerLog

  action_fallback TestProjWeb.FallbackController

  def get_visitor_count(conn, %{"name" => name}) do
    visitor_count = CustomerLogs.get_visitor_count(name)
    render(conn, :show_visitor_count, visitor_count: visitor_count)
  end

  def get_profit(conn, %{"name" => name}) do
    profit = CustomerLogs.get_profit(name)
    render(conn, :show_profit, profit: profit)
  end

  def get_dish_summary(conn, %{"type" => type}) do
    label = case type do
      "popular" -> "most_popular_dish"
      "profitable" -> "most_profitable_dish"
      _ -> "dish"
    end
    dish_summary = CustomerLogs.get_dish_for_all_restaurants(type)
    render(conn, :show_summary, summary: dish_summary, label: label)
  end

  def get_customer_summary(conn, %{"type" => type}) do
    label = case type do
      "most_frequent" -> "most_frequent_customer"
      _ -> "customer"
    end
    customer_summary = CustomerLogs.get_customer_summary(type)
    render(conn, :show_summary, summary: customer_summary, label: label)
  end

  def get_customer_type(conn, %{"type" => type}) do
    name = CustomerLogs.get_customer(type)
    render(conn, :show_customer, name: name)
  end
end
