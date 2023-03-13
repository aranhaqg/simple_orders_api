# SimpleOrdersApi
A simple products order REST API in Elixir with no auth.
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Available endpoints

**GET localhost:4000/api/users/:name**

You can pass in :name any user namer you want to check. Ex: ```localhost:4000/api/users/aranha```

**GET localhost:4000/api/products**
This action list all available products.

**POST localhost:4000/api/orders**

This is a example of params body used to create an order.
```
{"order": {"items": ["product-1", "product-2"], "user_id": "johndoe"}}
````

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
