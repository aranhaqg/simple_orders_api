defmodule SimpleOrdersApi.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias SimpleOrdersApi.Repo

  alias SimpleOrdersApi.Catalog.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias SimpleOrdersApi.Catalog.Order

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Order
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id) |> Repo.preload(:user)

  @spec create_order() :: any()
  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, order} ->
        # Preload the user association
        {:ok, Repo.preload(order, :user)}

      error ->
        error
    end
  end

  def create_order(%Order{total: total, user_id: user_id}, items: items) do
    order_params = %{
      total: total,
      user_id: user_id
    }

    Repo.transaction(fn ->
      {:ok, order} = create_order(order_params)

      Enum.each(items, fn item ->
        product = Repo.get_by(Product, sku: item)
        create_order_product(%{order_id: order.id, product_id: product.id})
      end)
    end)
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  alias SimpleOrdersApi.Catalog.OrderProduct

  @doc """
  Returns the list of orders_products.

  ## Examples

      iex> list_orders_products()
      [%OrderProduct{}, ...]

  """
  def list_orders_products do
    Repo.all(OrderProduct)
  end

  @doc """
  Gets a single order_product.

  Raises `Ecto.NoResultsError` if the Order product does not exist.

  ## Examples

      iex> get_order_product!(123)
      %OrderProduct{}

      iex> get_order_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_product!(id), do: Repo.get!(OrderProduct, id)

  @doc """
  Creates a order_product.

  ## Examples

      iex> create_order_product(%{field: value})
      {:ok, %OrderProduct{}}

      iex> create_order_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_product(attrs \\ %{}) do
    %OrderProduct{}
    |> OrderProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_product.

  ## Examples

      iex> update_order_product(order_product, %{field: new_value})
      {:ok, %OrderProduct{}}

      iex> update_order_product(order_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_product(%OrderProduct{} = order_product, attrs) do
    order_product
    |> OrderProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_product.

  ## Examples

      iex> delete_order_product(order_product)
      {:ok, %OrderProduct{}}

      iex> delete_order_product(order_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_product(%OrderProduct{} = order_product) do
    Repo.delete(order_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_product changes.

  ## Examples

      iex> change_order_product(order_product)
      %Ecto.Changeset{data: %OrderProduct{}}

  """
  def change_order_product(%OrderProduct{} = order_product, attrs \\ %{}) do
    OrderProduct.changeset(order_product, attrs)
  end
end
