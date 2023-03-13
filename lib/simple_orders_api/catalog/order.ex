defmodule SimpleOrdersApi.Catalog.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  alias SimpleOrdersApi.Admin.User

  schema "orders" do
    field :total, :decimal

    belongs_to(:user, User)
    timestamps()
  end

  @required [:total, :user_id]
  def changeset(order, attrs) do
    order
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> assoc_constraint(:user)
  end

end
