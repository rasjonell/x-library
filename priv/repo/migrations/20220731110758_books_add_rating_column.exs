defmodule BooksApi.Repo.Migrations.BooksAddRatingColumn do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :rating, :float
    end
  end
end
