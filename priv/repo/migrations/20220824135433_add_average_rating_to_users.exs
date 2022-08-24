defmodule BooksApi.Repo.Migrations.AddAverageRatingToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :average_rating, :float, default: nil
    end
  end
end
