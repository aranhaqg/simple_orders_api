defmodule SimpleOrdersApiWeb.OrderControllerTest do
  use SimpleOrdersApiWeb.ConnCase

  alias SimpleOrdersApi.Admin
  alias SimpleOrdersApi.Catalog
  alias SimpleOrdersApi.Catalog.Order

  @update_attrs %{
    total: "456.7"
  }
  @invalid_attrs %{total: nil}

  def create_attrs() do
    {:ok, user} = Admin.create_user(%{name: "some name", balance: 1000.00})
    %{total: 120.5, user_id: user.id}
  end

  def fixture(:order) do
    {:ok, order} = Catalog.create_order(create_attrs())
    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: create_attrs())
      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert id != nil

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "total" => "120.5"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert json_response(conn, :unprocessable_entity)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => _id,
               "total" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @invalid_attrs)
      assert json_response(conn, :unprocessable_entity)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    %{order: order}
  end
end
