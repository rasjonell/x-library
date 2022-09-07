defmodule BooksApiWeb.Router do
  use BooksApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BooksApiWeb.Auth.Pipeline
  end

  scope "/api", BooksApiWeb do
    pipe_through :api

    # Accounts
    post "/users/signup", UserController, :sign_up
    post "/users/signin", UserController, :sign_in
    post "/users/refresh", UserController, :refresh
  end

  scope "/api", BooksApiWeb do
    pipe_through [:api, :auth]

    # Library
    get "/users/:id/reviews", ReviewController, :list_user_reviews
    get "/users/reviews", ReviewController, :list_user_reviews
    get "/users/me", UserController, :get_user
    get "/users/:id", UserController, :get_user

    resources "/books", BookController, except: [:new, :edit] do
      post "/read", BookController, :read
      post "/review", BookController, :add_review
      delete "/review/:review_id", BookController, :remove_review
    end

    get "/reviews/:id", ReviewController, :show

    post "/books/:isbn", BookController, :create_with_isbn

    # Authentication
    post "/users/signout", UserController, :sign_out
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
