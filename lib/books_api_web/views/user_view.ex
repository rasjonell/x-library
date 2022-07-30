defmodule BooksApiWeb.UserView do
  use BooksApiWeb, :view

  @fields [:email]

  def render("user.json", %{user: user, token: token}) do
    render_json(%{user: user, token: token}, [:token | @fields], [], [])
  end

  def render("user.json", %{user: user}) do
    render_json(user, @fields, [], [])
  end
end
