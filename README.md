# X Library

Self-Hosted, Open, and Editable Library Management Platform 

![Banner Photo](./x-library.png)


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

## API Usage Docs

Base URLs:

* <a href="http://localhost:4000">http://localhost:4000</a>

# Authorization

- HTTP Authentication, scheme: bearer 

<h1 id="x-library-api-docs-authentication">Authentication</h1>

## post__api_users_signup

`POST /api/users/signup`

*Creates a new user*

> Body parameter

```json
{
  "user": {
    "email": "string",
    "password": "string"
  }
}
```

<h3 id="post__api_users_signup-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[user_req](#schemauser_req)|true|none|

> Example responses

> 201 Response

```json
{
  "email": "string",
  "token": "string"
}
```

<h3 id="post__api_users_signup-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|User was created|[user_resp](#schemauser_resp)|

<aside class="success">
This operation does not require authentication
</aside>

## post__api_users_signin

`POST /api/users/signin`

*Logs the user in*

> Body parameter

```json
{
  "user": {
    "email": "string",
    "password": "string"
  }
}
```

<h3 id="post__api_users_signin-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[user_req](#schemauser_req)|true|none|

> Example responses

> 201 Response

```json
{
  "email": "string",
  "token": "string"
}
```

<h3 id="post__api_users_signin-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|User was signed in|[user_resp](#schemauser_resp)|

<aside class="success">
This operation does not require authentication
</aside>

## post__api_users_signout

`POST /api/users/signout`

*Deletes current session*

> Example responses

> 200 Response

```json
{
  "success": true
}
```

<h3 id="post__api_users_signout-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|User was signed out|Inline|

<h3 id="post__api_users_signout-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» success|boolean|false|none|request status|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

<h1 id="x-library-api-docs-books">Books</h1>

## get__api_books

`GET /api/books`

*Returns all books.*

<h3 id="get__api_books-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|page|query|number|false|Pagination index|
|page_size|query|number|false|Number of resources in a single page|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  },
  "pagination": {
    "page_number": 0,
    "page_size": 0,
    "total_entries": 0,
    "total_pages": 0
  }
}
```

<h3 id="get__api_books-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Successful response|[book_paginated](#schemabook_paginated)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## post__api_books

`POST /api/books`

*Create a new book*

> Body parameter

```json
{
  "book": {
    "title": "string",
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ]
  }
}
```

<h3 id="post__api_books-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[book_req](#schemabook_req)|true|none|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="post__api_books-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Book was created|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## post__api_books_{isbn}

`POST /api/books/{isbn}`

*Create a new book from ISBN number*

<h3 id="post__api_books_{isbn}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|isbn|path|string|true|ISBN number of the book|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="post__api_books_{isbn}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Book was created|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## get__api_books_{id}

`GET /api/books/{id}`

*Get a single book*

<h3 id="get__api_books_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|ID of the book|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="get__api_books_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Successful response|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## put__api_books_{id}

`PUT /api/books/{id}`

*Update a single book*

> Body parameter

```json
{
  "book": {
    "title": "string",
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ]
  }
}
```

<h3 id="put__api_books_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[book_req](#schemabook_req)|true|none|
|id|path|string|true|ID of the book|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="put__api_books_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Successfully updated|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## patch__api_books_{id}

`PATCH /api/books/{id}`

*Update a single book*

> Body parameter

```json
{
  "book": {
    "title": "string",
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ]
  }
}
```

<h3 id="patch__api_books_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[book_req](#schemabook_req)|true|none|
|id|path|string|true|ID of the book|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="patch__api_books_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Successfully updated|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## delete__api_books_{id}

`DELETE /api/books/{id}`

*Delete a book*

<h3 id="delete__api_books_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|ID of the book|

<h3 id="delete__api_books_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|Successfully deleted|None|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

<h1 id="x-library-api-docs-library">Library</h1>

## post__api_books_{id}_read

`POST /api/books/{id}/read`

*Mark book as read*

<h3 id="post__api_books_{id}_read-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|ID of the book|

> Example responses

> 200 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="post__api_books_{id}_read-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Successfully marked book as read|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## post__api_books_{id}_review

`POST /api/books/{id}/review`

*Add a review for a book*

> Body parameter

```json
{
  "review": {
    "id": "string",
    "content": "string",
    "rating": 0,
    "book_id": "string",
    "user_id": "string"
  }
}
```

<h3 id="post__api_books_{id}_review-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[review_req](#schemareview_req)|true|none|
|id|path|string|true|ID of the book|

> Example responses

> 201 Response

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}
```

<h3 id="post__api_books_{id}_review-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Successfully added a review|[book_resp](#schemabook_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## delete__api_books_{book_id}_review_{review_id}

`DELETE /api/books/{book_id}/review/{review_id}`

*Remove a review for a book*

<h3 id="delete__api_books_{book_id}_review_{review_id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|book_id|path|string|true|ID of the book|
|review_id|path|string|true|ID of the review|

<h3 id="delete__api_books_{book_id}_review_{review_id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|204|[No Content](https://tools.ietf.org/html/rfc7231#section-6.3.5)|Successfully removed the review|None|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## get__api_users_reviews

`GET /api/users/reviews`

*Lists all reviews of the currently signed in user*

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "string",
      "content": "string",
      "rating": 0,
      "book_id": "string",
      "user_id": "string"
    }
  ]
}
```

<h3 id="get__api_users_reviews-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|List of reviews of the current user|[review_resp](#schemareview_resp)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## get__api_users_{id}_reviews

`GET /api/users/{id}/reviews`

*Lists all reviews of the specified user*

<h3 id="get__api_users_{id}_reviews-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|ID of the user|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "id": "string",
      "content": "string",
      "rating": 0,
      "book_id": "string",
      "user_id": "string"
    }
  ]
}
```

<h3 id="get__api_users_{id}_reviews-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|List of reviews of the given user|[review_resp](#schemareview_resp)|

<aside class="success">
This operation does not require authentication
</aside>

## get__api_users_{id}

`GET /api/users/{id}`

*Get the Profile of the given User*

<h3 id="get__api_users_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|ID of the user|

> Example responses

> 200 Response

```json
{
  "id": "string",
  "email": "string",
  "books_read": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  },
  "reviews": {
    "id": "string",
    "content": "string",
    "rating": 0,
    "book_id": "string",
    "user_id": "string"
  }
}
```

<h3 id="get__api_users_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|User Profile with reviews and books|[user](#schemauser)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

## get__api_users_me

`GET /api/users/me`

*Get the Profile of the currently signed in user*

> Example responses

> 200 Response

```json
{
  "id": "string",
  "email": "string",
  "books_read": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  },
  "reviews": {
    "id": "string",
    "content": "string",
    "rating": 0,
    "book_id": "string",
    "user_id": "string"
  }
}
```

<h3 id="get__api_users_me-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Profile of the given User with reviews and books|[user](#schemauser)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
bearerAuth
</aside>

# Schemas

<h2 id="tocS_book_resp">book_resp</h2>
<!-- backwards compatibility -->
<a id="schemabook_resp"></a>
<a id="schema_book_resp"></a>
<a id="tocSbook_resp"></a>
<a id="tocsbook_resp"></a>

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[book](#schemabook)|false|none|none|

<h2 id="tocS_books_resp">books_resp</h2>
<!-- backwards compatibility -->
<a id="schemabooks_resp"></a>
<a id="schema_books_resp"></a>
<a id="tocSbooks_resp"></a>
<a id="tocsbooks_resp"></a>

```json
{
  "data": [
    {
      "id": "string",
      "title": "string",
      "rating": 0,
      "price": 0,
      "isbn": "string",
      "description": "string",
      "authors": [
        "string"
      ],
      "read_by": [
        {
          "id": "string",
          "email": "string",
          "books_read": {},
          "reviews": {
            "id": "string",
            "content": "string",
            "rating": 0,
            "book_id": "string",
            "user_id": "string"
          }
        }
      ],
      "reviews": [
        {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      ]
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[[book](#schemabook)]|false|none|none|

<h2 id="tocS_book_req">book_req</h2>
<!-- backwards compatibility -->
<a id="schemabook_req"></a>
<a id="schema_book_req"></a>
<a id="tocSbook_req"></a>
<a id="tocsbook_req"></a>

```json
{
  "book": {
    "title": "string",
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ]
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|book|object|false|none|none|
|» title|string|false|none|Title of the book|
|» price|number|false|none|Price of the book|
|» isbn|string|false|none|ISBN number of the book|
|» description|string|false|none|Description of the book|
|» authors|[string]|false|none|none|

<h2 id="tocS_book">book</h2>
<!-- backwards compatibility -->
<a id="schemabook"></a>
<a id="schema_book"></a>
<a id="tocSbook"></a>
<a id="tocsbook"></a>

```json
{
  "id": "string",
  "title": "string",
  "rating": 0,
  "price": 0,
  "isbn": "string",
  "description": "string",
  "authors": [
    "string"
  ],
  "read_by": [
    {
      "id": "string",
      "email": "string",
      "books_read": {
        "id": "string",
        "title": "string",
        "rating": 0,
        "price": 0,
        "isbn": "string",
        "description": "string",
        "authors": [
          "string"
        ],
        "read_by": [],
        "reviews": [
          {
            "id": "string",
            "content": "string",
            "rating": 0,
            "book_id": "string",
            "user_id": "string"
          }
        ]
      },
      "reviews": {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    }
  ],
  "reviews": [
    {
      "id": "string",
      "content": "string",
      "rating": 0,
      "book_id": "string",
      "user_id": "string"
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|ID of the book|
|title|string|false|none|Title of the book|
|rating|number|false|none|Average rating of the book|
|price|number|false|none|Price of the book|
|isbn|string|false|none|ISBN number of the book|
|description|string|false|none|Description of the book|
|authors|[string]|false|none|none|
|read_by|[[user](#schemauser)]|false|none|none|
|reviews|[[review](#schemareview)]|false|none|none|

<h2 id="tocS_book_paginated">book_paginated</h2>
<!-- backwards compatibility -->
<a id="schemabook_paginated"></a>
<a id="schema_book_paginated"></a>
<a id="tocSbook_paginated"></a>
<a id="tocsbook_paginated"></a>

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  },
  "pagination": {
    "page_number": 0,
    "page_size": 0,
    "total_entries": 0,
    "total_pages": 0
  }
}

```

### Properties

allOf

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|[book_resp](#schemabook_resp)|false|none|none|

and

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|[pagination](#schemapagination)|false|none|none|

<h2 id="tocS_pagination">pagination</h2>
<!-- backwards compatibility -->
<a id="schemapagination"></a>
<a id="schema_pagination"></a>
<a id="tocSpagination"></a>
<a id="tocspagination"></a>

```json
{
  "pagination": {
    "page_number": 0,
    "page_size": 0,
    "total_entries": 0,
    "total_pages": 0
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|pagination|object|false|none|none|
|» page_number|number|false|none|Current page number|
|» page_size|number|false|none|Current or given page size|
|» total_entries|number|false|none|Total count of the requested resource|
|» total_pages|number|false|none|Available pages|

<h2 id="tocS_user_req">user_req</h2>
<!-- backwards compatibility -->
<a id="schemauser_req"></a>
<a id="schema_user_req"></a>
<a id="tocSuser_req"></a>
<a id="tocsuser_req"></a>

```json
{
  "user": {
    "email": "string",
    "password": "string"
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|user|object|false|none|none|
|» email|string|false|none|Email of the user|
|» password|string|false|none|Password of the user|

<h2 id="tocS_user_resp">user_resp</h2>
<!-- backwards compatibility -->
<a id="schemauser_resp"></a>
<a id="schema_user_resp"></a>
<a id="tocSuser_resp"></a>
<a id="tocsuser_resp"></a>

```json
{
  "email": "string",
  "token": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|email|string|false|none|Email of the user|
|token|string|false|none|JWT of the created session|

<h2 id="tocS_user">user</h2>
<!-- backwards compatibility -->
<a id="schemauser"></a>
<a id="schema_user"></a>
<a id="tocSuser"></a>
<a id="tocsuser"></a>

```json
{
  "id": "string",
  "email": "string",
  "books_read": {
    "id": "string",
    "title": "string",
    "rating": 0,
    "price": 0,
    "isbn": "string",
    "description": "string",
    "authors": [
      "string"
    ],
    "read_by": [
      {
        "id": "string",
        "email": "string",
        "books_read": {},
        "reviews": {
          "id": "string",
          "content": "string",
          "rating": 0,
          "book_id": "string",
          "user_id": "string"
        }
      }
    ],
    "reviews": [
      {
        "id": "string",
        "content": "string",
        "rating": 0,
        "book_id": "string",
        "user_id": "string"
      }
    ]
  },
  "reviews": {
    "id": "string",
    "content": "string",
    "rating": 0,
    "book_id": "string",
    "user_id": "string"
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|ID of the user|
|email|string|false|none|Email of the user|
|books_read|[book](#schemabook)|false|none|none|
|reviews|[review](#schemareview)|false|none|none|

<h2 id="tocS_review_req">review_req</h2>
<!-- backwards compatibility -->
<a id="schemareview_req"></a>
<a id="schema_review_req"></a>
<a id="tocSreview_req"></a>
<a id="tocsreview_req"></a>

```json
{
  "review": {
    "id": "string",
    "content": "string",
    "rating": 0,
    "book_id": "string",
    "user_id": "string"
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|review|[review](#schemareview)|false|none|none|

<h2 id="tocS_review_resp">review_resp</h2>
<!-- backwards compatibility -->
<a id="schemareview_resp"></a>
<a id="schema_review_resp"></a>
<a id="tocSreview_resp"></a>
<a id="tocsreview_resp"></a>

```json
{
  "data": [
    {
      "id": "string",
      "content": "string",
      "rating": 0,
      "book_id": "string",
      "user_id": "string"
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[[review](#schemareview)]|false|none|none|

<h2 id="tocS_review">review</h2>
<!-- backwards compatibility -->
<a id="schemareview"></a>
<a id="schema_review"></a>
<a id="tocSreview"></a>
<a id="tocsreview"></a>

```json
{
  "id": "string",
  "content": "string",
  "rating": 0,
  "book_id": "string",
  "user_id": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|ID of the reivew|
|content|string|false|none|Content of the review|
|rating|integer|false|none|Rating of the review|
|book_id|string|false|none|ID of the book for the review|
|user_id|string|false|none|ID of the user who left the review|



## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
