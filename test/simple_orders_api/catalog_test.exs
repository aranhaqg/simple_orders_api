defmodule SimpleOrdersApi.CatalogTest do
  use SimpleOrdersApi.DataCase

  alias SimpleOrdersApi.Catalog

  describe "products" do
    alias SimpleOrdersApi.Catalog.Product

    @valid_attrs %{name: "some name", price: "120.5", sku: "some sku"}
    @update_attrs %{name: "some updated name", price: "456.7", sku: "some updated sku"}
    @invalid_attrs %{name: nil, price: nil, sku: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Catalog.create_product(@valid_attrs)
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
      assert product.sku == "some sku"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Catalog.update_product(product, @update_attrs)
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
      assert product.sku == "some updated sku"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  describe "orders" do
    alias SimpleOrdersApi.Catalog.Order

    @valid_attrs %{total: "120.5"}
    @update_attrs %{total: "456.7"}
    @invalid_attrs %{total: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Catalog.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Catalog.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Catalog.create_order(@valid_attrs)
      assert order.total == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Catalog.update_order(order, @update_attrs)
      assert order.total == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_order(order, @invalid_attrs)
      assert order == Catalog.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Catalog.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Catalog.change_order(order)
    end
  end

  describe "orders_products" do
    alias SimpleOrdersApi.Catalog.OrderProduct

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def order_product_fixture(attrs \\ %{}) do
      {:ok, order_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_order_product()

      order_product
    end

    test "list_orders_products/0 returns all orders_products" do
      order_product = order_product_fixture()
      assert Catalog.list_orders_products() == [order_product]
    end

    test "get_order_product!/1 returns the order_product with given id" do
      order_product = order_product_fixture()
      assert Catalog.get_order_product!(order_product.id) == order_product
    end

    test "create_order_product/1 with valid data creates a order_product" do
      assert {:ok, %OrderProduct{} = order_product} = Catalog.create_order_product(@valid_attrs)
    end

    test "create_order_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_order_product(@invalid_attrs)
    end

    test "update_order_product/2 with valid data updates the order_product" do
      order_product = order_product_fixture()

      assert {:ok, %OrderProduct{} = order_product} =
               Catalog.update_order_product(order_product, @update_attrs)
    end

    test "update_order_product/2 with invalid data returns error changeset" do
      order_product = order_product_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Catalog.update_order_product(order_product, @invalid_attrs)

      assert order_product == Catalog.get_order_product!(order_product.id)
    end

    test "delete_order_product/1 deletes the order_product" do
      order_product = order_product_fixture()
      assert {:ok, %OrderProduct{}} = Catalog.delete_order_product(order_product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_order_product!(order_product.id) end
    end

    test "change_order_product/1 returns a order_product changeset" do
      order_product = order_product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_order_product(order_product)
    end
  end
end
