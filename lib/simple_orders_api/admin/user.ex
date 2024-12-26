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
  @required [:name, :balance]
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> unique_constraint(:name)
  end
end
