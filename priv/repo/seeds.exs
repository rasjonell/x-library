# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BooksApi.Repo.insert!(%BooksApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start()

alias BooksApi.{Library, Accounts}

books = [
  %{
    title: "Less Than Nothing: Hegel and the Shadow of Dialectical Materialism",
    description:
      "For the last two centuries, Western philosophy has developed in the shadow of Hegel, an influence each new thinker struggles to escape. As a consequence, Hegel’s absolute idealism has become the bogeyman of philosophy, obscuring the fact that he is the defining philosopher of the historical transition to modernity, a period with which our own times share startling similarities.",
    isbn: "9781781681275",
    price: 33.5,
    authors: ["Slavoj Žižek"]
  },
  %{
    title: "The Phoenix Project: A Novel About IT, DevOps, and Helping Your Business Win",
    description:
      "In a fast-paced and entertaining style, three luminaries of the DevOps movement deliver a story that anyone who works in IT will recognize. Readers will not only learn how to improve their own IT organizations, they'll never view IT the same way again.",
    isbn: "9781942788294",
    price: 24.6,
    authors: ["Gene Kim", "Kevin Behr", "George Spafford"]
  },
  %{
    title: "THE 6:20 MAN",
    description:
      "When his ex-girlfriend turns up dead in his office building, an entry-level investment analyst delves into the halls of economic power.",
    authors: ["David Baldacci"],
    price: 0.00,
    publisher: "Grand Central",
    isbn: "9781538719848"
  },
  %{
    title: "PORTRAIT OF AN UNKNOWN WOMAN",
    description:
      "The 22nd book in the Gabriel Allon series. Allon becomes an art forger to uncover a multibillion-dollar fraud.",
    authors: ["Daniel Silva"],
    price: 0.00,
    publisher: "Harper",
    isbn: "9780062834850"
  },
  %{
    title: "THE HOTEL NANTUCKET",
    description:
      "The new general manager of a hotel far from its Gilded Age heyday deals with the complicated pasts of her guests and staff.",
    authors: ["Elin Hilderbrand"],
    price: 0.00,
    publisher: "Little, Brown",
    isbn: "9780316258678"
  },
  %{
    title: "THE IT GIRL",
    description:
      "A decade after her first year at Oxford, an expectant mother looks into the mystery of her former best friend’s death.",
    authors: ["Ruth Ware"],
    price: 0.00,
    publisher: "Scout",
    isbn: "9781982155261"
  },
  %{
    title: "SHATTERED",
    description:
      "The 14th book in the Michael Bennett series. When an F.B.I. abduction specialist disappears, Bennett goes outside his jurisdiction.",
    authors: ["James Patterson and James O. Born"],
    price: 0.00,
    publisher: "Little, Brown",
    isbn: "9780316499484"
  },
  %{
    title: "SPARRING PARTNERS",
    description: "Three novellas: “Homecoming,” “Strawberry Moon” and “Sparring Partners.”",
    authors: ["John Grisham"],
    price: 0.00,
    publisher: "Doubleday",
    isbn: "9780385549325"
  },
  %{
    title: "TOMORROW, AND TOMORROW, AND TOMORROW",
    description:
      "Two friends find their partnership challenged in the world of video game design.",
    authors: ["Gabrielle Zevin"],
    price: 0.00,
    publisher: "Knopf",
    isbn: "9780593321201"
  },
  %{
    title: "THE MIDNIGHT LIBRARY",
    description:
      "Nora Seed finds a library beyond the edge of the universe that contains books with multiple possibilities of the lives one could have lived.",
    authors: ["Matt Haig"],
    price: 0.00,
    publisher: "Viking",
    isbn: "9780525559474"
  },
  %{
    title: "THE MEASURE",
    description:
      "People around the world receive a small wooden box telling them the exact number of years they will live.",
    authors: ["Nikki Erlick"],
    price: 0.00,
    publisher: "Morrow",
    isbn: "9780063204201"
  },
  %{
    title: "THE LAST THING HE TOLD ME",
    description:
      "Hannah Hall discovers truths about her missing husband and bonds with his daughter from a previous relationship.",
    authors: ["Laura Dave"],
    price: 0.00,
    publisher: "Simon & Schuster",
    isbn: "9781501171345"
  },
  %{
    title: "THE LAST TO VANISH",
    description:
      "The manager of a resort in the mountains of North Carolina looks into unsolved disappearances.",
    authors: ["Megan Miranda"],
    price: 0.00,
    publisher: "Marysue Rucci/Scribner",
    isbn: "9781982147310"
  },
  %{
    title: "LESSONS IN CHEMISTRY",
    description:
      "A scientist and single mother living in California in the 1960s becomes a star on a TV cooking show.",
    authors: ["Bonnie Garmus"],
    price: 0.00,
    publisher: "Doubleday",
    isbn: "9780385547345"
  },
  %{
    title: "RISING TIGER",
    description:
      "The 21st book in the Scot Harvath series. The American spy faces dangers on a mission in an unfamiliar culture.",
    authors: ["Brad Thor"],
    price: 0.00,
    publisher: "Atria/Emily Bestler",
    isbn: "9781982182151"
  },
  %{
    title: "THE PARIS APARTMENT",
    description: "Jess has suspicions about her half-brother’s neighbors when he goes missing.",
    authors: ["Lucy Foley"],
    price: 0.00,
    publisher: "Morrow",
    isbn: "9780063003057"
  },
  %{
    title: "SEA OF TRANQUILITY",
    description:
      "A detective investigating in the wilderness discovers that his actions might affect the timeline of the universe.",
    authors: ["St. John Mandel"],
    price: 0.00,
    publisher: "Knopf",
    isbn: "9780593321447,"
  }
]

{:ok, %Accounts.User{} = user} =
  Accounts.create_user(%{name: "Test User", email: "test@example.com", password: "strong_pass"})

add_books = fn book_params ->
  {:ok, %Library.Book{} = book} =
    Library.create_book(%{book_params | price: Faker.Commerce.price()})

  {:ok, %Library.Book{}} =
    Library.add_review(book.id, user.id, %{
      "content" => Faker.StarWars.quote(),
      "rating" => Faker.random_between(0, 5)
    })

  if Faker.random_between(0, 5) > 2.5 do
    with_readers = BooksApi.Repo.preload(book, [:read_by])
    Library.read_book(with_readers, user)
  end
end

Enum.each(books, fn b -> add_books.(b) end)
