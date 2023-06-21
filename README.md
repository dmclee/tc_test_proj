# TestProj

## Requirements
This service uses the following:

- MySQL
- Phoenix
- Elixir 1.14
- Erlang/OTP 24

To start your Phoenix server:

  * Update `config/dev.exs` with the database credentials
  * To pre-populate the database, prepare a CSV file with the data and add it to `/priv/repo/data/data.csv`. 
  * Run `mix setup` to install and setup dependencies, and also to populate the database with the data. Please note that the setup will only ingest the data if the table is empty.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API Documentation

Can be found in `docs/api.md`.

## Solution

After ingesting the data to SQL, I decided to create APIs that retrieves data for the restaurant, for all restaurants, and for a customer.

The APIs for a specific restaurant is pretty straight forward where an aggregation is performed then filtered by the restaurant name. To get the visitor counts, I took the count of all first names; to get the profit, I took the sum of the food costs. 

In the APIs for all restaurants, since I wanted to get a summary for all, I first retrieved a list of all restaurant names. Then, I queried the requested data (most popular dish, etc) per restaurant. I also designed the endpoint to accept a type so that it would be easier to reuse this url path if there is a need to add more summaries (e.g. least popular dish)

For the customer API is almost the same as the restaurant API wherein an aggregation is performed and then filtered by the needed data. In this case, when getting the customer who visited the most stores, I got the count of instances for each first name and returned the one with the highest value.

## Additional questions:

*How would you build this differently if the data was being streamed from Kafka?*

If data was being streamed, firstly, I would have added functions that handle creation, update, and deletion of data in the database.

In the parts that gets the summary of data for each restaurant, I would probably add a cache layer that contains the last value computed/selected for those. This cache will only be cleared if an event for the restaurant has been received. By doing so there is no need to have a call to the database for those that didn't have any changes. Another alternative design is to create a separate table for these summaries where data is updated by triggers in the database. 

*How would you improve the deployment of this system?*

I would add tests and error handling in the code. Also, if possible, maybe try to add it to a docker container.