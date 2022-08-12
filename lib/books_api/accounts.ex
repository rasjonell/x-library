defmodule BooksApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BooksApi.Repo

  alias BooksApi.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload([:books_read, :reviews])
  end

  def get_user_by_email(email) do
    preloaded_user =
      User
      |> Repo.get_by(email: email)
      |> Repo.preload([:books_read, :reviews])

    case preloaded_user do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, user}
    end
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
