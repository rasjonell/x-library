defmodule BooksApi.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :rating, :integer
      add :content, :text
      add :book_id, references(:books, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:reviews, [:book_id])
    create index(:reviews, [:user_id])
    create unique_index(:reviews, [:user_id, :book_id], name: :unique_review_users_books)
  end
end
