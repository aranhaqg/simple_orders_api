defmodule SimpleOrdersApi.Catalog.OrderProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders_products" do
    field :order_id, :binary_id
    field :product_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order_product, attrs) do
    order_product
    |> cast(attrs, [])
    |> validate_required([])
  end
end
