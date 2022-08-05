defmodule BooksApi.Repo do
  use Ecto.Repo,
    otp_app: :books_api,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
