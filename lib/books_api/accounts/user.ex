defmodule BooksApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BooksApi.Library.{Book, Review}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :bio, :string
    field :email, :string
    field :average_rating, :float
    field :encrypted_password, :string

    field :password, :string, virtual: true

    many_to_many :books_read, Book, join_through: "users_read_books"

    has_many :reviews, Review

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :bio, :email, :password, :average_rating])
    |> validate_required([:name, :bio, :email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_length(:bio, min: 3, max: 150)
    |> unique_constraint(:email)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
