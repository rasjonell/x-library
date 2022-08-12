defmodule BooksApi.Repo.Migrations.AddProfileInfoToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
    end
  end
end
