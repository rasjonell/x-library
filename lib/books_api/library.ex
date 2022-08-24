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

  @open_lib_url "https://openlibrary.org"

  def list_books(params) do
    Book
    |> preload([:read_by, :reviews])
    |> Repo.paginate(params)
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

  def create_book_with_isbn(isbn) do
    case HTTPoison.get(isbn_url(isbn), [], follow_redirect: true) do
      {:ok, %{status_code: 200, body: body}} ->
        decoded_body = Poison.decode!(body)

        %{status_code: 200, body: author_body} = HTTPoison.get!(author_url(decoded_body))

        decoded_author = Poison.decode!(author_body)

        book_params = %{
          isbn: isbn,
          rating: nil,
          title: decoded_body["title"],
          price: Faker.Commerce.price(),
          authors: [decoded_author["name"]],
          description: decoded_body["subtitle"]
        }

        create_book(book_params)

      {:ok, %{status_code: 404}} ->
        {:error, :not_found}
    end
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

  def delete_review(%Review{} = review, book_id, user_id) do
    Repo.delete!(review)
    update_ratings(book_id, user_id)
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
        update_ratings(book_id, user_id)

      {:error, error} ->
        {:error, error}
    end
  end

  defp update_ratings(book_id, user_id) do
    book = get_book!(book_id)
    user = Accounts.get_user!(user_id)

    book_ratings = Enum.map(book.reviews, fn %{rating: rating} -> rating end)
    user_ratings = Enum.map(user.reviews, fn %{rating: rating} -> rating end)

    Accounts.update_user(user, %{average_rating: get_average(user_ratings)})
    update_book(book, %{rating: get_average(book_ratings)})
  end

  defp get_average([]), do: nil

  defp get_average(ratings) do
    Enum.sum(ratings) / length(ratings)
  end

  defp isbn_url(isbn), do: @open_lib_url <> "/isbn/" <> isbn <> ".json"

  defp author_url(decoded_body) do
    key = decoded_body["authors"] |> List.first() |> Map.get("key")
    @open_lib_url <> key <> ".json"
  end
end
