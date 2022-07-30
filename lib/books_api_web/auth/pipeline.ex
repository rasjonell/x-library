defmodule BooksApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :books_api,
    module: BooksApiWeb.Auth.Guardian,
    error_handler: BooksApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
