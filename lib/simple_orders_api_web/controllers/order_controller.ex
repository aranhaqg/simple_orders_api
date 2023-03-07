defmodule SimpleOrdersApiWeb.OrderController do
  use SimpleOrdersApiWeb, :controller

  alias SimpleOrdersApi.Catalog
  alias SimpleOrdersApi.Catalog.Order

  action_fallback SimpleOrdersApiWeb.FallbackController

  def index(conn, _params) do
    orders = Catalog.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Catalog.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Catalog.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Catalog.get_order!(id)

    with {:ok, %Order{} = order} <- Catalog.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Catalog.get_order!(id)

    with {:ok, %Order{}} <- Catalog.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
