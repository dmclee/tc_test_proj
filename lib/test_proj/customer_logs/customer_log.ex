defmodule TestProj.CustomerLogs.CustomerLog do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "customer_log" do
    field :first_name, :string
    field :food_cost, :float
    field :food_names, :string
    field :restaurant_names, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer_log, attrs) do
    customer_log
    |> cast(attrs, [:restaurant_names, :food_names, :first_name, :food_cost])
    |> validate_required([:restaurant_names, :food_names, :first_name, :food_cost])
  end

  @doc """
  Adds the query to match the restaurant's name
  """
  def for_restaurant(query, name) do
    from(cl in query,
      where: cl.restaurant_names == ^name
    )
  end

  @doc """
  Adds the query to select the total money earned
  """
  def select_total_profit(query) do
    from(cl in query,
      select: sum(cl.food_cost)
    )
  end

  @doc """
  Adds the query to select the count for visitors
  """
  def select_visitor_count(query) do
    from(cl in query,
      select: count(cl.first_name)
    )
  end

  @doc """
  Adds the query to select restaurant names
  """
  def select_restaurant_names(query) do
    from(cl in query,
      select: cl.restaurant_names
    )
  end

  @doc """
  Adds the query to select customer names
  """
  def select_customer_names(query) do
    from(cl in query,
      select: cl.first_name
    )
  end

  @doc """
  Selects the most frequent dish
  """
  def select_popular_dish_count(query) do
    from(cl in query,
      select: cl.food_names,
      group_by: cl.food_names,
      order_by: [desc: count(1)],
      limit: 1
    )
  end

  @doc """
  Selects the most profitable dish
  """
  def select_profitable_dish(query) do
    from(cl in query,
      select: cl.food_names,
      group_by: cl.food_names,
      order_by: [desc: sum(cl.food_names)],
      limit: 1
    )
  end

  @doc """
  Selects the customer who visited most
  """
  def select_most_frequent_customer(query) do
    from(cl in query,
      select: cl.first_name,
      group_by: cl.first_name,
      order_by: [desc: count(1)],
      limit: 1
    )
  end

  @doc """
  Group results by the restaurant name
  """
  def group_by_restaurant(query) do
    from(cl in query,
      group_by: cl.restaurant_names
    )
  end

  @doc """
  Group results food name
  """
  def group_by_food_names(query) do
    from(cl in query,
      group_by: cl.food_names
    )
  end

  @doc """
  Group results by first name
  """
  def group_by_first_names(query) do
    from(cl in query,
      group_by: cl.first_name
    )
  end

end
