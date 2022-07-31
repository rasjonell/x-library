defmodule BooksApi.LibraryTest do
  use BooksApi.DataCase

  alias BooksApi.Library

  describe "books" do
    alias BooksApi.Library.Book

    import BooksApi.LibraryFixtures

    @invalid_attrs %{authors: nil, description: nil, isbn: nil, price: nil, title: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Library.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Library.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{authors: [], description: "some description", isbn: "some isbn", price: 120.5, title: "some title"}

      assert {:ok, %Book{} = book} = Library.create_book(valid_attrs)
      assert book.authors == []
      assert book.description == "some description"
      assert book.isbn == "some isbn"
      assert book.price == 120.5
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{authors: [], description: "some updated description", isbn: "some updated isbn", price: 456.7, title: "some updated title"}

      assert {:ok, %Book{} = book} = Library.update_book(book, update_attrs)
      assert book.authors == []
      assert book.description == "some updated description"
      assert book.isbn == "some updated isbn"
      assert book.price == 456.7
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_book(book, @invalid_attrs)
      assert book == Library.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Library.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Library.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Library.change_book(book)
    end
  end

  describe "reviews" do
    alias BooksApi.Library.Review

    import BooksApi.LibraryFixtures

    @invalid_attrs %{content: nil, rating: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Library.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Library.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{content: "some content", rating: 42}

      assert {:ok, %Review{} = review} = Library.create_review(valid_attrs)
      assert review.content == "some content"
      assert review.rating == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{content: "some updated content", rating: 43}

      assert {:ok, %Review{} = review} = Library.update_review(review, update_attrs)
      assert review.content == "some updated content"
      assert review.rating == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_review(review, @invalid_attrs)
      assert review == Library.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Library.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Library.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Library.change_review(review)
    end
  end
end
