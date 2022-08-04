defmodule BooksApiWeb.BookController do
  use BooksApiWeb, :controller

  alias BooksApi.Library
  alias BooksApi.Library.{Book, Review}

  action_fallback BooksApiWeb.FallbackController

  def index(conn, _params) do
    books = Library.list_books()
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Library.create_book(book_params) do
      conn
      |> put_status(:created)
      |> render("show.json", book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    render(conn, "show.json", book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book!(id)

    with {:ok, %Book{} = book} <- Library.update_book(book, book_params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)

    with {:ok, %Book{}} <- Library.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end

  def read(conn, %{"book_id" => id}) do
    book = Library.get_book!(id)
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Book{} = book} <- Library.read_book(book, user) do
      render(conn, "show.json", book: book)
    end
  end

  def add_review(conn, %{"review" => review_params, "book_id" => book_id}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %Book{} = book} <- Library.add_review(book_id, user.id, review_params) do
      conn
      |> put_status(:created)
      |> render("show.json", book: book)
    end
  end

  def remove_review(conn, %{"review_id" => review_id, "book_id" => book_id}) do
    review = Library.get_review!(review_id)

    with {:ok, %Book{}} <- Library.delete_review(review, book_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
