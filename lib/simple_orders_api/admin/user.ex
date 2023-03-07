defmodule SimpleOrdersApi.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :balance, :decimal
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :balance])
    |> validate_required([:name, :balance])
    |> unique_constraint(:name)
  end
end
