defmodule BooksApiWeb.UserView do
  use BooksApiWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
