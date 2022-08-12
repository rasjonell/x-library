defmodule BooksApiWeb.UserController do
  use BooksApiWeb, :controller

  alias BooksApi.Accounts
  alias BooksApi.Accounts.User
  alias BooksApiWeb.Auth.Guardian

  action_fallback BooksApiWeb.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, access_token, _claims} <-
           Guardian.encode_and_sign(user, %{}, token_type: "access"),
         {:ok, refresh_token, _claims} <-
           Guardian.encode_and_sign(user, %{}, token_type: "refresh") do
      conn
      |> put_status(:created)
      |> render("user.json", user: user, token: access_token, refresh: refresh_token)
    end
  end

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, user, access_token, refresh_token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: access_token, refresh: refresh_token})
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

  def refresh(conn, %{"refresh" => refresh_token}) do
    {:ok, claims} = Guardian.decode_and_verify(refresh_token)
    {:ok, current_user} = Guardian.resource_from_claims(claims)

    with {:ok, user, access_token, refresh_token} <-
           Guardian.refresh_token(current_user, refresh_token) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: access_token, refresh: refresh_token})
    end
  end

  def get_user(conn, %{"id" => user_id}) do
    user = Accounts.get_user!(user_id)
    render(conn, "user.json", user: user)
  end

  def get_user(conn, _params) do
    user =
      conn
      |> Guardian.Plug.current_resource()
      |> BooksApi.Repo.preload([:books_read, :reviews])

    render(conn, "user.json", user: user)
  end
end
