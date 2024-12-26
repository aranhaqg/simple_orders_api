defmodule SimpleOrdersApiWeb.UserController do
  use SimpleOrdersApiWeb, :controller

  alias SimpleOrdersApi.Admin
  alias SimpleOrdersApi.Admin.User
  alias SimpleOrdersApi.Repo

  action_fallback SimpleOrdersApiWeb.FallbackController

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Admin.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SimpleOrdersApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"name" => name}) do
    user = Repo.get_by(User, name: name)

    if user do
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:not_found)
      |> render(SimpleOrdersApiWeb.ErrorView, "404.json")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    case Admin.update_user(user, user_params) do
      {:ok, %User{} = user} ->
        render(conn, "show.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SimpleOrdersApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)

    case Admin.delete_user(user) do
      {:ok, %User{}} ->
        send_resp(conn, :no_content, "")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SimpleOrdersApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
