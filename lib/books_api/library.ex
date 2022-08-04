defmodule BooksApi.Library do
  @moduledoc """
  The Library context.
  """

  alias BooksApi.Library
  alias BooksApi.Accounts

  import Ecto.Query, warn: false
  alias BooksApi.Repo

  alias BooksApi.Library.Book
  alias BooksApi.Accounts.User

  def list_books do
    Book
    |> Repo.all()
    |> Repo.preload([:read_by, :reviews])
  end

  def get_book!(id) do
    Book
    |> Repo.get!(id)
    |> Repo.preload([:read_by, :reviews])
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

  alias BooksApi.Library.Review

  def list_reviews(user_id) do
    Accounts.get_user!(user_id)
    |> Repo.preload([:reviews])
    |> Map.get(:reviews)
  end

  def get_review!(id), do: Repo.get!(Review, id)

  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  def delete_review(%Review{} = review, book_id) do
    Repo.delete!(review)
    update_ratings(book_id)
  end

  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end

  def add_review(book_id, user_id, review_params) do
    case review_params
         |> Map.put("book_id", book_id)
         |> Map.put("user_id", user_id)
         |> Library.create_review() do
      {:ok, _review} ->
        update_ratings(book_id)

      {:error, error} ->
        {:error, error}
    end
  end

  defp update_ratings(book_id) do
    book = get_book!(book_id)

    ratings = Enum.map(book.reviews, fn %{rating: rating} -> rating end)

    update_book(book, %{rating: get_average(ratings)})
  end

  defp get_average([]), do: nil

  defp get_average(ratings) do
    Enum.sum(ratings) / length(ratings)
  end
end
