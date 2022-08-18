defmodule BooksApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use BooksApiWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(BooksApiWeb.ErrorView, :"404")
  end

  # This clause will handle invalid resource data.
  def call(conn, {:error, %Ecto.Changeset{} = error}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(BooksApiWeb.ErrorView, :"422", error: error)
  end

  # This clause will handle unauthorized requests
  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(BooksApiWeb.ErrorView, :"401")
  end

  # This clause will handle incorrect email/passwords
  def call(conn, {:error, :incorrect_credentials}) do
    conn
    |> put_status(:unauthorized)
    |> render(BooksApiWeb.ErrorView, "incorrect_credentials.json")
  end
end
