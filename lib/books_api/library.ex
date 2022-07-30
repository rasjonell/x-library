defmodule BooksApi.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias BooksApi.Repo

  alias BooksApi.Library.Book
  alias BooksApi.Accounts.User

  def list_books do
    Book
    |> Repo.all()
    |> Repo.preload([:read_by])
  end

  def get_book!(id) do
    Book
    |> Repo.get!(id)
    |> Repo.preload([:read_by])
  end

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  def read_book(%Book{} = book, %User{} = user) do
    book
    |> Book.changeset(%{})
    |> Ecto.Changeset.put_assoc(:read_by, [user])
    |> Repo.update()
  end
end
