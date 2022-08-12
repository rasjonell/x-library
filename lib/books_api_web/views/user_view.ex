defmodule BooksApiWeb.UserView do
  use BooksApiWeb, :view

  alias BooksApiWeb.{BookView, ReviewView}

  @fields [:id, :email]
  @relationships [books_read: BookView, reviews: ReviewView]

  def render("user.json", %{user: user, token: token, refresh: refresh_token}) do
    data =
      user
      |> Map.put_new(:token, token)
      |> Map.put_new(:refresh, refresh_token)

    render_json(data, [:token, :refresh | @fields], [], @relationships)
  end

  def render("user.json", %{user: user}) do
    render_json(user, @fields, [], @relationships)
  end
end
