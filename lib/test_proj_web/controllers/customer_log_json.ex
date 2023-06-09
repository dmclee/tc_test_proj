defmodule TestProjWeb.CustomerLogJSON do
  @doc """
  Renders the visitor count
  """
  def show_visitor_count(%{visitor_count: count}) do
    %{data: %{visitor_count: count}}
  end

  @doc """
  Renders the profit the restaurant received
  """
  def show_profit(%{profit: profit}) do
    %{data: %{profit: profit}}
  end

  @doc """
  Renders the summary per restaurant
  """
  def show_summary(%{summary: summary, label: label}) do
    %{
      data: Enum.map(Map.keys(summary), &(
        %{
          "restaurant_name" => &1,
          label => summary[&1]
        })
      )
    }
  end

  @doc """
  Renders the summary of the dishes per restaurant
  """
  def show_customer(%{name: name}) do
    %{
      data: %{first_name: name}
    }
  end
end
