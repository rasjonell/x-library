defmodule BooksApiWeb.ReviewView do
  use BooksApiWeb, :view
  alias BooksApiWeb.{ReviewView, UserView, BookView}

  @fields [:id, :rating, :content, :book_id, :user_id]
  @relationships [user: UserView, book: BookView]

  def render("index.json", %{reviews: reviews}) do
    %{data: render_many(reviews, ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    render_json(review, @fields, [], @relationships)
  end
end
