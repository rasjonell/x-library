defmodule BooksApiWeb.Auth.Guardian do
  use Guardian, otp_app: :books_api

  alias BooksApi.Accounts

  def subject_for_token({:ok, %Accounts.User{} = user}, claims) do
    subject_for_token(user, claims)
  end

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)

    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = BooksApi.Repo.get!(Accounts.User, id)

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
    {:ok, access_token, _claims} = encode_and_sign(user, %{}, token_type: "access")
    {:ok, refresh_token, _claims} = encode_and_sign(user, %{}, token_type: "refresh")
    {:ok, user, access_token, refresh_token}
  end

  def refresh_token(user, token) do
    {:ok, _claims} = decode_and_verify(token)
    create_token(user)
  end

  # GuardianDB Hooks

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
