# X Library

Self-Hosted, Open, and Editable Library Management Platform 

![Banner Photo](./x-library.png)

_Check out the cross-platform mobile client for this API: [X-Library Mobile](https://github.com/rasjonell/x-library-mobile)_

# Ideas To Implement Next

- [ ] Federated Network of Book Reviews/Recommendations
  - Ability for peers to sync with other peers
  - Social networking capabilities(follow users from other instances(ActivityPub?))

- [ ] RSS Feed for reviews
  - Use ISBN database services to link the book inside the review to an external source

- [ ] Statistics
  - GoodReads style statistics for both books and users

- [x] Add books from an external source
  - use OpenLibrary or a similar service to fetch books with the ISBN number

# Note for Clients

The API now allows book creation/addition with only the ISBN number, thus, the [OpenLibrary API](https://openlibrary.org/developers/api) can be leveraged  in your client to search for books, authors, genres, etc. Then use the retrieved ISBN to add the book to the X Library platform.

# Development

## Setup

To start your Phoenix server:
  * Update `dev.exs` config with your database credentials
  * Rename `dev.example_secrets.exs` to `dev.secrets.exs` and follow the examples to setup the authentication secrets.
  * Install dependencies with `mix deps.get`
  * Create, migrate, and seed your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Usage

Check out the OpenAPI Docs Website: https://rasjonell.github.io/x-library/

Or jump to [API Usage Docs](#api-usage-docs)

You can [download](https://raw.githubusercontent.com/rasjonell/x-library/main/x-library-api-spec.yaml) the OpenApi spec and import it in Insomnia or Postman and get a testable API.

### Importing OpenAPI specs into your favorite API platform.

- Postman: [Working With OpenAPI](https://learning.postman.com/docs/integrations/available-integrations/working-with-openAPI/)
- Insomnia:
  - Open up Insomnia
  - Navigate to Dashboard
  - Click `Create`
  - Choose `URL`
  - Paste this URL: `https://raw.githubusercontent.com/rasjonell/x-library/main/x-library-api-spec.yaml`
  - Answer the prompts to create a new Design Document
