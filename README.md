# Books API

Elixir/Phoenix Books CRUD API with JWT Authentication


## Setup

To start your Phoenix server:
  * Update `dev.exs` config with your database credentials
  * Rename `dev.example_secrets.exs` to `dev.secrets.exs` and follow the examples to setup the authentication secrets.
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`


## Usage

### Auth

To use the Books API you first need to authenticate:

```json
POST    /api/users/signup   {
                              "user": {
                                "email": "valid@email.com",
                                "password": "strong_password"
                              }
                            }


POST    /api/users/signin   {
                              "email": "your@email.com",
                              "password": "your password"                          
                            }
```

Both of these actions return `token` which should be used as auth headers:
`Authorization: Bearer {{token}}`

### Books

There is a basic CRUD API available.

This is the required json body when creating/updating books.
```json
{
  "book": {
      "title": "Book Title",
      "isbn": "0123456789",
      "description": "Some Book Description",
      "price": 0.0,
      "authors": ["Karl Marx", "Friedrich Engels"]
    }
}
```

```
GET         /api/books              
GET         /api/books/:id          
POST        /api/books              
PATCH       /api/books/:id          
PUT         /api/books/:id          
DELETE      /api/books/:id
```



## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
