defmodule BooksApi.Library.Review do
  use Ecto.Schema
  import Ecto.Changeset

  alias BooksApi.Library.Book
  alias BooksAPi.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :content, :string
    field :rating, :integer
    belongs_to :book, Book
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:rating, :content, :book_id, :user_id])
    |> validate_required([:rating, :book_id, :user_id])
    |> unique_constraint(:unique_review, name: :unique_review_users_books)
  end
end
