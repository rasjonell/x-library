defmodule BooksApiWeb.ReviewView do
  use BooksApiWeb, :view

  @fields [:id, :rating, :content]

  def render("review.json", %{review: review}) do
    render_json(review, @fields, [], [])
  end
end
