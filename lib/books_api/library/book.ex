defmodule BooksApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias BooksApi.Accounts.User
  alias BooksApi.Library.Review

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :authors, {:array, :string}
    field :description, :string
    field :isbn, :string
    field :title, :string
    field :rating, :float

    many_to_many :read_by, User, join_through: "users_read_books"

    has_many :reviews, Review

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :authors, :rating])
    |> validate_required([:title, :isbn, :description, :authors])
    |> unique_constraint(:isbn)
  end
end
