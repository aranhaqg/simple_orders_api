defmodule SimpleOrdersApi.Catalog.OrderProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  alias SimpleOrdersApi.Catalog.Order
  alias SimpleOrdersApi.Catalog.Product

  schema "orders_products" do
    #field :order_id, :binary_id
    #field :product_id, :binary_id

    belongs_to(:order, Order)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  @required [:order_id, :product_id]
  def changeset(order_product, attrs) do
    order_product
    |> cast(attrs, @required)
    |> validate_required([])
    |> assoc_constraint(:order)
    |> assoc_constraint(:product)
  end
end
