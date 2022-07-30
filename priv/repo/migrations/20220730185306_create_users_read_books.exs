defmodule BooksApi.Repo.Migrations.CreateUsersReadBooks do
  use Ecto.Migration

  def change do
    create table(:users_read_books, primary_key: false) do
      add :user_id, references(:users)
      add :book_id, references(:books)
    end

    create unique_index(:users_read_books, [:user_id, :book_id])
  end
end
