defmodule BooksApi.Repo.Migrations.RemovePriceFromBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :price, :float, default: nil
    end
  end
end
