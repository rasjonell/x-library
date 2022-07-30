import Config

config :books_api, BooksApiWeb.Auth.Guardian,
  issuer: "books_api",
  # generate with `mix guardian.gen.secret`
  secret_key: "YOUR_SECRET_KEY"
