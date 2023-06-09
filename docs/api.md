# API Documentation

This serves as a guide on how to use the provided APIs in this service. 

All the provided APIs will return JSON-encoded responses and will pass through `/api`

## Available Actions

- [Getting Restaurant Data](#getting-restaurant-data)
- [Getting Summary for Restaurants](#getting-summary-for-restaurants)
- [Getting a Customer](#getting-a-customer)

------

## Getting Restaurant Data

This endpoint will be able to provide the following:
- [Number of visitors the restaurant has](#number-of-restaurant-visitors)
- [Amount of profit the restaurant earned](#amount-of-profit)

### Number of Restaurant Visitors

**Endpoint**: `/restaurant/:name/visitor_count`

**Parameter**:
  - name -> Type: String, the name of the restaurant

In this given sample request, the API will return how many customers visited the "Restaurant at the end of the universe".

**Sample Request**
```
curl "localhost:4000/api/restaurant/the-restaurant-at-the-end-of-the-universe/visitor_count"
```
**Sample Response**
```
{
  "data":{
    "visitor_count": 37230
  }
}
```

### Amount of Profit

**Endpoint**: `/restaurant/:name/profit`

**Parameter**:
  - name -> Type: String, the name of the restaurant

In this given sample request, the API will return how much profit the "Restaurant at the end of the universe" has earned.

**Sample Request**
```
curl "localhost:4000/api/restaurant/the-restaurant-at-the-end-of-the-universe/profit"
```
**Sample Response**
```
{
  "data":{
    "profit": 186944.0
  }
}
```

------

## Getting Summary for Restaurants

This endpoint will be able to provide the following:
- [Most popular dish at each restaurant](#most-popular-dish)
- [Most profitable dish for each restaurant](#most-profitable-dish)
- [Most frequent customer for each restaurant](#most-frequent-customer)

### Most Popular Dish

**Endpoint**: `/restaurants/dish/:type`

**Parameter**:
  - type -> Type: String, accepted values are ["popular", "profitable"]

In this given sample request, the API will return a summary of the most popular dishes for each restaurant.

**Sample Request**
```
curl "localhost:4000/api/restaurants/dish/popular"
```
**Sample Response**
```
{
  "data": [
    {
      "restaurant_name": "bean-juice-stand",
      "most_popular_dish": "honey"
    },
    {
      "restaurant_name": "johnnys-cashew-stand",
      "most_popular_dish": "juice"
    },
    {
      "restaurant_name": "the-ice-cream-parlor",
      "most_popular_dish": "beans"
    },
    {
      "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
      "most_popular_dish": "cheese"
    }
  ]
}
```

### Most Profitable Dish

**Endpoint**: `/restaurants/dish/:type`

**Parameter**:
  - type -> Type: String, accepted values are ["popular", "profitable"]

In this given sample request, the API will return a summary of the most profitable dishes for each restaurant.

**Sample Request**
```
curl "localhost:4000/api/restaurants/dish/profitable"
```
**Sample Response**
```
{
  "data": [
    {
      "restaurant_name": "bean-juice-stand",
      "most_profitable_dish": "vegetables"
    },
    {
      "restaurant_name": "johnnys-cashew-stand",
      "most_profitable_dish": "soup"
    },
    {
      "restaurant_name": "the-ice-cream-parlor",
      "most_profitable_dish": "candy"
    },
    {
      "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
      "most_profitable_dish": "chips"
    }
  ]
}
```

### Most Frequent Customer

**Endpoint**: `/restaurants/customer/:type`

**Parameter**:
  - type -> Type: String, accepted values are ["most_frequent"]

In this given sample request, the API will return a summary of the most frequent visitor for each restaurant.

**Sample Request**
```
curl "localhost:4000/api/restaurants/customer/most_frequent"
```
**Sample Response**
```
{
  "data": [
    {
      "restaurant_name": "bean-juice-stand",
      "most_frequent_customer": "Michael"
    },
    {
      "restaurant_name": "johnnys-cashew-stand",
      "most_frequent_customer": "Michael"
    },
    {
      "restaurant_name": "the-ice-cream-parlor",
      "most_frequent_customer": "Michael"
    },
    {
      "restaurant_name": "the-restaurant-at-the-end-of-the-universe",
      "most_frequent_customer": "Michael"
    }
  ]
}
```

------

## Getting A Customer

This endpoint will be able to provide the following:
- [Customer who visited the most restaurants](#visited-the-most)

### Visited the Most

**Endpoint**: `/customer/:type`

**Parameter**:
  - type -> Type: String, accepted values are ["most_visited"]

In this given sample request, the API will return the name of the customer who has visited the most.

**Sample Request**
```
curl "localhost:4000/api/customer/most_frequent"
```
**Sample Response**
```
{
  "data":{
    "first_name": "Michael"
  }
}
```

