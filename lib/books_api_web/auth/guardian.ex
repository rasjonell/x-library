defmodule BooksApiWeb.Auth.Guardian do
  use Guardian, otp_app: :books_api

  alias BooksApi.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)

    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)

    {:ok, resource}
  end

  def authenticate(email, password) do
    with {:ok, user} <- Accounts.get_user_by_email(email) do
      case Comeonin.Bcrypt.checkpw(password, user.encrypted_password) do
        true ->
          create_token(user)

        false ->
          {:error, :unauthorized}
      end
    end
  end

  def create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
