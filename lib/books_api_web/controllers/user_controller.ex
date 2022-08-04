defmodule BooksApiWeb.UserController do
  use BooksApiWeb, :controller

  alias BooksApi.Accounts
  alias BooksApi.Accounts.User
  alias BooksApiWeb.Auth.Guardian

  action_fallback BooksApiWeb.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user, token: token)
    end
  end

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def sign_out(conn, _opts) do
    {:ok, _claims} =
      conn
      |> Guardian.Plug.current_token()
      |> Guardian.revoke()

    conn
    |> put_status(:ok)
    |> json(%{success: true})
  end
end
