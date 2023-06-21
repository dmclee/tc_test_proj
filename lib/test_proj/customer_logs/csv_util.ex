defmodule TestProj.CustomerLogs.CSVUtil do
  @moduledoc """
  Helper module to ingest a file to populate the customer_logs database
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias TestProj.CustomerLogs.CustomerLog
  alias TestProj.Repo

  def import_data(file) do
    with true <- File.exists?(file),
        false <- Repo.exists?(CustomerLog)
    do
      import_data_from_file(file)
    else
      _any -> :ok
    end
  end

  def import_data_from_file(file) do
    column_names = get_column_names(file)
    timestamp = DateTime.truncate(DateTime.utc_now(), :second)

    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: true)
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Map.new(fn {val, num} -> {column_names[num], val} end)
      |> prepare_rows(timestamp)
    end
    )
    |> batch_insert(100)
  end

  def get_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  def prepare_rows(row, timestamp) do
    %{
      restaurant_names: row["restaurant_names"],
      food_names: row["food_names"],
      first_name: row["first_name"],
      food_cost: String.to_float(row["food_cost"]),
      inserted_at: timestamp,
      updated_at: timestamp
    }
  end

  def batch_insert([], _size), do: :ok
  def batch_insert(logs, size) do
    {cur_batch, next_batch} = Enum.split(logs, size)
    Repo.insert_all(CustomerLog, cur_batch, on_conflict: :nothing)
    batch_insert(next_batch, size)
  end

end
