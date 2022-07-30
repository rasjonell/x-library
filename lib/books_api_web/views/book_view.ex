defmodule BooksApiWeb.BookView do
  use BooksApiWeb, :view
  alias BooksApiWeb.BookView

  @fields [:id, :title, :isbn, :description, :price, :authors]
  @relationships [read_by: BooksApiWeb.UserView]
  @custom_fields [:read_by_count]

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    render_json(book, @fields, @custom_fields, @relationships)
  end

  def render_field(:read_by_count, book) do
    BooksApi.Library.Book.read_by_count(book)
  end
end
