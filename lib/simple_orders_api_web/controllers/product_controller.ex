defmodule SimpleOrdersApiWeb.ProductController do
  use SimpleOrdersApiWeb, :controller

  alias SimpleOrdersApi.Catalog
  alias SimpleOrdersApi.Catalog.Product

  action_fallback SimpleOrdersApiWeb.FallbackController

  def index(conn, _params) do
    products = Catalog.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    case Catalog.create_product(product_params) do
      {:ok, %Product{} = product} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.product_path(conn, :show, product))
        |> render("show.json", product: product)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SimpleOrdersApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Catalog.get_product!(id)

    case Catalog.update_product(product, product_params) do
      {:ok, %Product{} = product} ->
        conn
        |> render("show.json", product: product)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SimpleOrdersApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)

    with {:ok, %Product{}} <- Catalog.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
