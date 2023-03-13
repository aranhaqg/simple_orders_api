# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SimpleOrdersApi.Repo.insert!(%SimpleOrdersApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, user} = SimpleOrdersApi.Admin.create_user(%{balance: 100.00, name: "aranha" })

{:ok, product1} = SimpleOrdersApi.Catalog.create_product(%{name: "Blue Pencil", price: 10.5, sku: "blue-pencil" })
{:ok, product2} = SimpleOrdersApi.Catalog.create_product(%{name: "Red Pencil", price: 10.5, sku: "red-pencil" })
{:ok, product3} = SimpleOrdersApi.Catalog.create_product(%{name: "Orange Notepad", price: 50.9, sku: "orange-notepad" })


{:ok, order} = SimpleOrdersApi.Catalog.create_order(%{total: 20.10, user_id: user.id})
SimpleOrdersApi.Catalog.create_order_product(%{order_id: order.id, product_id: product1.id})
