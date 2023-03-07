defmodule SimpleOrdersApi.Catalog.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :total, :decimal
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:total])
    |> validate_required([:total])
  end
end
