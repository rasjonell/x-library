defmodule BooksApiWeb.BookView do
  use BooksApiWeb, :view
  alias BooksApiWeb.{BookView, UserView, ReviewView, PageView}

  @fields [:id, :title, :isbn, :description, :price, :authors, :rating]
  @relationships [read_by: UserView, reviews: ReviewView]

  def render("index.json", %{books: books, page: page}) do
    %{
      data: render_many(books, BookView, "book.json"),
      pagination: render_one(page, PageView, "page.json")
    }
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    render_json(book, @fields, [], @relationships)
  end
end
