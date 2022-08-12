import Config

config :books_api, BooksApiWeb.Auth.Guardian,
  issuer: "books_api",
  # generate with `mix guardian.gen.secret`
  secret_key: "YOUR_SECRET_KEY",
  ttl: {1, :days},
  token_ttl: %{
    "refresh" => {30, :days},
    "access" => {1, :days}
  }
