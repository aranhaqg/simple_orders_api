defmodule SimpleOrdersApi.Catalog.OrderProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  alias SimpleOrdersApi.Catalog.Order
  alias SimpleOrdersApi.Catalog.Product

  schema "orders_products" do
    belongs_to(:order, Order)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  def changeset(order_product, attrs) do
    order_product
    |> cast(attrs, [:order_id, :product_id])
    |> validate_required([:order_id, :product_id])
    |> assoc_constraint(:order)
    |> assoc_constraint(:product)
  end
end
