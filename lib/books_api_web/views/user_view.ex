defmodule BooksApiWeb.UserView do
  use BooksApiWeb, :view

  alias BooksApiWeb.{BookView, ReviewView}

  @fields [:id, :email]
  @relationships [books_read: BookView, reviews: ReviewView]

  def render("user.json", %{user: user, token: token}) do
    data = Map.put_new(user, :token, token)
    render_json(data, [:token | @fields], [], @relationships)
  end

  def render("user.json", %{user: user}) do
    render_json(user, @fields, [], @relationships)
  end
end
