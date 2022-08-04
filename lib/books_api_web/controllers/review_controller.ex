defmodule BooksApiWeb.ReviewController do
  use BooksApiWeb, :controller

  alias BooksApi.Library

  action_fallback BooksApiWeb.FallbackController

  def list_user_reviews(conn, %{"id" => user_id}) do
    reviews = Library.list_reviews(user_id)
    render(conn, "index.json", reviews: reviews)
  end

  def list_user_reviews(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    reviews = Library.list_reviews(user.id)
    render(conn, "index.json", reviews: reviews)
  end
end
