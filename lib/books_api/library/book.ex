defmodule BooksApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias BooksApi.Library.Book
  alias BooksApi.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :authors, {:array, :string}
    field :description, :string
    field :isbn, :string
    field :price, :float
    field :title, :string

    many_to_many :read_by, User, join_through: "users_read_books"

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :price, :authors])
    |> validate_required([:title, :isbn, :description, :price, :authors])
    |> unique_constraint(:isbn)
  end

  def read_by_count(%Book{read_by: read_by}) do
    length(read_by)
  end
end
