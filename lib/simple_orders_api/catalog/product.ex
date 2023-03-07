defmodule SimpleOrdersApi.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :price, :decimal
    field :sku, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :name, :price])
    |> validate_required([:sku, :name, :price])
    |> unique_constraint(:sku)
  end
end
