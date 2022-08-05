defmodule BooksApiWeb.PageView do
  use BooksApiWeb, :view

  @fields [:page_number, :page_size, :total_entries, :total_pages]

  def render("page.json", %{page: page}) do
    render_json(page, @fields, [], [])
  end
end
